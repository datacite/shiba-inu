# Pipeline for DOI Resolution Logs processing

[![Build Status](https://travis-ci.org/datacite/shiba-inu.svg?branch=master)](https://travis-ci.org/datacite/shiba-inu) [![Docker Build Status](https://img.shields.io/docker/build/datacite/shiba-inu.svg)](https://hub.docker.com/r/datacite/shiba-inu/) [![Maintainability](https://api.codeclimate.com/v1/badges/a0d15834af2cdc24e22f/maintainability)](https://codeclimate.com/github/datacite/shiba-inu/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/a0d15834af2cdc24e22f/test_coverage)](https://codeclimate.com/github/datacite/shiba-inu/test_coverage)


Shiba-Inu is pipeline for DOI Resolution Logs processing. The pipeline processes DOI resolution logs following the [Code of practice for research data usage metrics](https://doi.org/10.7287/peerj.preprints.26505v1). Its based in Logstash.


![The Shiba Inu is the smallest of the six original and distinct spitz breeds of dog from Japan.](https://i.imgur.com/ueW0Leo.jpg)


## Installation

Using Docker.

```
docker run -p 8075:80 datacite/shiba-inu
```

You can now point your browser to `http://localhost:8075` and use the application.


## Development

We use Rspec for unit and acceptance testing:

```
bundle exec rspec
```

Follow along via [Github Issues](https://github.com/datacite/shiba-inu/issues).

### Note on Patches/Pull Requests

* Fork the project
* Write tests for your new feature or a test that reproduces a bug
* Implement your feature or make a bug fix
* Do not mess with Rakefile, version or history
* Commit, push and make a pull request. Bonus points for topical branches.

## License
**shiba-inu** is released under the [MIT License](https://github.com/datacite/shiba-inu/blob/master/LICENSE).
