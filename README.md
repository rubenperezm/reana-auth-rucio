# REANA Authentication Rucio

[![image](https://github.com/reanahub/reana-auth-rucio/workflows/CI/badge.svg)](https://github.com/reanahub/reana-auth-rucio/actions)
[![image](https://img.shields.io/badge/discourse-forum-blue.svg)](https://forum.reana.io)
[![image](https://img.shields.io/github/license/reanahub/reana-auth-rucio.svg)](https://github.com/reanahub/reana-auth-rucio/blob/master/LICENSE)

## About

`reana-auth-rucio` provides a container image for creating the right Rucio configuration
for REANA workflow jobs. The container image includes no additional logic or libraries,
just the bare minimum to support Rucio. The image is configured to support authentication
for the four experiments at CERN's Large Hadron Collider (ALICE, ATLAS, CMS, LHCb), as
well as [ESCAPE](https://projectescape.eu/) Virtual Organization.

`reana-auth-rucio` was developed for use in the [REANA](http://www.reana.io/) reusable
research data analysis platform.

## Usage

You can use `reana-auth-rucio` as a base image, however it was built to be used as a
sidecar container with the single purpose of creating the right Rucio configuration. Once
obtained, the configuration files are shared with the main container using common
namespaces.

The end users can ask for Rucio support by means of declaring `rucio: true`. Currently,
the container requires VOMS authentication meaning that `voms_proxy: true` has also to be
declared, enabling the
[reana-auth-vomsproxy](https://github.com/reanahub/reana-auth-vomsproxy) sidecar
container.

Inside the container Rucio commands can be executed, for example via:

```console
$ rucio whoami
```

## Dependencies

Building the container and successfully obtaining Rucio configuration requires additional
files present in this repository:

- `files/CERN-bundle.pem` downloaded from
  [Rucio GitLab repository](https://gitlab.cern.ch/plove/rucio/-/tree/master/etc/web);
- `files/rucio.cfg.j2` Rucio configuration template.

## Changes

### Version 1.1.1 (2023-09-11)

- Adds more WLCG certificates to facilitate data access to outside-CERN sites.

### Version 1.1.0 (2023-08-22)

- Changes Rucio client version to 1.30.0.
- Changes installation to use fully-qualified container image names to be Podman
  friendly.
- Fixes EGI trustanchors installation troubles by switching to CERN CA bundles.

### Version 1.0.0 (2022-10-13)

- Initial release.

## Development

You can build the `reana-auth-rucio` image by optionally passing the build arguments
`BASETAG` in order to specify the tag of `rucio/rucio-clients`.

## More information

For more information about [REANA](https://www.reana.io/) reusable research data analysis
platform, please see [its documentation](https://docs.reana.io/).
