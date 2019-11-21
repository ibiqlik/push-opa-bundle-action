# Push OPA policy bundle to an OCI registry - docker action

This action uses [Conftest](https://github.com/instrumenta/conftest) to bundle and push [OPA policies](https://www.openpolicyagent.org/) to a public or private registry.

Registries supporting OCI (Open Container Initiative) image format:

- Azure: https://azure.microsoft.com/en-us/services/container-registry/
- Google Cloud: https://cloud.google.com/container-registry/docs/image-formats#oci_format

## Inputs

### Required inputs

- `registry` - OCI Registry to push Bundles to. Example: `myregistry.azurecr.io`
- `bundle_name` - Bundle name (a.k.a. image/repository name). Example: `mypolicy`
- `tag` - Bundle (image) tag, can be a version, sha commit

### Optional inputs

- `tag_latest` - `true|false`; Alongside tagged bundle it will also push the latest tag. Default `"true"`. Example `mypolicy:latest`
- `path` - Path to policy directory or file that will be bundled and pushed. Default `"policy"`

## Environment Variables (required for private registries)

- `REGISTRY_USER` - Registry username (with Push/Write permissions)
- `REGISTRY_PWD` - Registry password


## Example usage

```
name: Publish OPA Policy
on: [push]
jobs:
  conftest:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Push policies
      uses: ibiqlik/push-opa-bundle-action@master
      with:
        registry: myregistry.azurecr.io
        bundle_name: opa-policy
        tag: ${{ github.sha }}
        tag_latest: "true"
        path: "policy"
      env:
        REGISTRY_USER: ${{ secrets.REGISTRY_USER }}
        REGISTRY_PWD: ${{ secrets.REGISTRY_PWD }}
```
