FROM flynn/cedarish

WORKDIR /tmp/builder
RUN curl -O https://raw.githubusercontent.com/flynn/flynn/master/slugbuilder/builder/install-buildpack
RUN curl -O https://raw.githubusercontent.com/flynn/flynn/master/slugbuilder/builder/build.sh
RUN chmod +x install-buildpack build.sh
RUN curl https://raw.githubusercontent.com/flynn/flynn/master/slugbuilder/builder/buildpacks.txt | xargs -L 1 ./install-buildpack /tmp/buildpacks

WORKDIR /tmp/runner
RUN curl -O https://raw.githubusercontent.com/flynn/flynn/master/slugrunner/runner/init
RUN echo '/tmp/runner/init $@ < /tmp/slug.tgz' > init_alias
RUN chmod +x init_alias

ONBUILD ADD . /tmp/code/
ONBUILD WORKDIR /tmp/code/
# exporting .env file from http://stackoverflow.com/a/20909045
ONBUILD RUN tar -c . | env $(cat build.env | xargs) /tmp/builder/build.sh


ENTRYPOINT ["/tmp/runner/init_alias"]
