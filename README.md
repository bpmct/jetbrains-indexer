# jetbrains-indexer

Generate & package JetBrains [shared indexes](https://www.jetbrains.com/help/idea/shared-indexes.html) with a Docker container.

Shared indexes are often hosted on a CDN and used by IDEs to speed up loading (indexing) time for JetBrains IDEs (IntelliJ IDEA, PyCharm, GoLand, etc). Blog post: <https://coder.com/blog/faster-jetbrains-ides-with-shared-indexes>

## Basic usage

1.  Generate indexes for your project

    ```sh
    cd your-project/

    docker run -it --rm \
        -v "$(pwd)":/var/project \
        -v "$HOME/indexes-out":/shared-index \
        -e INDEXES_CDN_URL=http://localhost:3000/project \
        bencdr/indexer:idea-2021.3
        
    # you may need to fix the file permissions for the generated indexes
    sudo chown -R $(id -u):$(id -g) $HOME/indexes-out
    ```

1.  Upload indexes to CDN (or test locally)

    ```sh
    # test with local Python server
    cd $HOME/indexes-out/
    python3 -m http.server 3000
    ```

    > this URL must be the same as INDEXES_CDN_URL in step 1.

1.  Add `intellij.yaml` to your project if you don't have one

    ```yaml
    sharedIndex:
      project:
        - url: http://localhost:3000/project
    ```

1.  Open your IDE and test (use `File → Invalidate Caches` to load indexes for the first time again)

## IDE support

By default, this project indexes version 2021.3 of your IDE. Specify the IDE name by using the appropriate tag (e.g `bencdr/indexer:[ide-name]-2021.3`). You can verify with [DockerHub](https://hub.docker.com/r/bencdr/indexer/tags).

If an IDE/version is not on DockerHub, we recommend you manually pulling and building the image yourself using [these build arguments](https://github.com/bpmct/jetbrains-indexer/blob/master/image/Dockerfile#L3-L9).

## Docs and examples

> ⚠️ Many of these are a work in progress

- [Test a project with shared indexes locally](./docs/filesystem.md)
- [Generate shared indexes for Coder workspaces](./docs/coder.md)
- [Generate shared indexes and host on a CDN](./docs/cdn.md)
- [Generate shared indexes regularly during CI (GitHub Actions)](./docs/ci.md)
- [Troubleshooting shared indexes](./docs/troubleshooting.md)

## Troubleshooting

See [./docs/troubleshooting.md](./docs/troubleshooting.md)

---

If you just want to generate raw shared indexes with Docker, you can use [damintsew/idea-shared-index-dockerfile](https://github.com/damintsew/idea-shared-index-dockerfile). This project is based on that.
