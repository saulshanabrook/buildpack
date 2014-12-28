# Buildpack
A base image that allows easy extension to run Heroku like apps.

## Quickstart
If you have a Heroku app, just run add a Dockerfile:

```
FROM saulshanabrook/buildpack
CMD start web
```

Build it

```bash
$ docker build -t app .
```

...and run it

```bash
$ docker run -rm -it -p 8080:8080 app .
```

## Environmental Variables
If you want to add some environmental variables when Docker is building
(for example to change the `BUILDPACK_URL`), just add them to a `build.env`
file in the root of your project.

```bash
$ echo 'BUILDPACK_URL=some_crazy_buildpack' >> build.env
```

## How does it work?
I have tried to keep this as small as possible, harnessing all of the actual
logic from Flynn's [slugbuilder](https://github.com/flynn/flynn/tree/master/slugbuilder)
and [slugrunner](https://github.com/flynn/flynn/tree/master/slugrunner).

I am basically copying those Dockerfiles and combinging them, so as to allow
a single image to inherit from which does everything, instead of passing
tarballs around of images and slugs.

Originally I wanted to use the advertised API for slugbuilder and slugrunner,
to build and run the slugs inside the my Docker build, but this would require
running Docker inside a Docker build, [which isn't possible yet](https://github.com/docker/docker/issues/1916#issuecomment-68063263)


## Which buildpacks do you support by defaults?
[The same ones supported by slugbuilder](https://github.com/flynn/flynn/blob/master/slugbuilder/builder/buildpacks.txt)


## Why don't you just use [tutum/buildstep](https://github.com/tutumcloud/buildstep)?
I tried it and it didn't work for my project for some reason. Since Flynn has
already done all the hard work, I figured it would be nice to harness their
projects and build off them.
