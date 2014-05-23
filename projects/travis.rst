Set up continous integration with travis-ci
======
Travis CI is a continuous integration website which is used for monitoring
the quality of a project and making sure no bugs creep into the code base.
I set up travis-ci builds for:

    Disco project https://github.com/discoproject/disco

    Hutle project https://github.com/chango/hustle

    Inferno project https://github.com/chango/inferno

    Disco Go worker: https://github.com/discoproject/goworker

These will run all of the supplied unittests for the project as soon as a pull
request is created and will let us only merge the pull requests if they do not
break anything.
