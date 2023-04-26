# gitbook-pub

<https://github.com/liyi4x/gitbook-pub>

## `gitbook-pub` action usage

```yml
name: 'Gitbook-Action'

on:
  push:
    branches:
      - master

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout action
      uses: actions/checkout@v3

    - name: Gitbook Action
      uses: liyi4x/gitbook-pub@v1.0.0
      with:
        time_zone: ${{ vars.TIME_ZONE }}  # Optional. System Default, if set, like Asia/Shanghai
        source_token: ${{ secrets.TOKEN }}  # Required. 
        source_hub: ${{ vars.SOURCE_HUB }}  # Optional. Default is 'github.com', can be gitlib.com  gitee.com ...
        source_repo: ${{ vars.SOURCE_REPO }}  # Optional. Default is GITHUB_REPOSITORY, if not please add like username/reponame
        source_branch: ${{ vars.SOURCE_BRANCH }}  # Optional. Default is  'master'
        git_name: ${{ vars.GIT_NAME }}  # Optional. Default is GITHUB_ACTOR, If git name is different with github, please add
        git_email: ${{ vars.GIT_EMAIL }} # Optional. Default is **@users.noreply.github.com If git email is different with github, please add
        publish_token: ${{ secrets.PUBLISH_TOKEN }}  # Optional. Default is same as 'source_token'
        publish_hub: ${{ secrets.PUBLISH_HUB }}  # Optional. Default is 'github.com'
        publish_repo: ${{ secrets.PUBLISH_REPO }}  # Optional. Default is same as 'source_repo'
        publish_branch: ${{ secrets.PUBLISH_BRANCH }}  # Optional. Default is 'gh-pages', auto create
```
## Files

- `action.yml`
  - The metadata file for `gitbook-pub` action
- `Dockerfile`
  - To build [liyi4x/gitbook-pub](https://hub.docker.com/r/liyi4x/gitbook-pub) docker image
  - `docker pull liyi4x/gitbook-pub`
- `main.sh`
  - The entrypoint for `liyi4x/gitbook-pub` image
- `.github/workflows/main.yml`
  - To build docker images and push to dockerhub
