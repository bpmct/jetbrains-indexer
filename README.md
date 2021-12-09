# jetbrains-indexer

Generate & package JetBrains [shared indexes](https://www.jetbrains.com/help/idea/shared-indexes.html) with a Docker container.

Shared indexes are often hosted on a CDN and used by IDEs to speed up loading (indexing) time for JetBrains IDEs (IntelliJ IDEA, PyCharm, GoLand, etc). Blog post: <https://coder.com/blog/faster-jetbrains-ides-with-shared-indexes>

## Docs and examples

- [Test a project with shared indexes locally](./docs/filesystem.md)
- [Generate shared indexes for Coder workspaces](./docs/coder.md)
- [Generate shared indexes and host on a CDN](./docs/cdn.md)
- [Generate shared indexes regularly during CI (GitHub Actions)](./docs/ci.md)

## Basic usage

1.  Generate indexes for your project

    ```sh
    cd your-project/

    docker run -it --rm \
        -v "$(pwd)":/var/project \
        -v "$HOME/indexes-out":/shared-index \
        -e INDEXES_CDN_URL=http://localhost:3000/project \
        bencdr/indexer
    ```

1.  Upload indexes to CDN (or test locally)

    ```sh
    # test with local Python server
    cd $HOME/indexes-out/
    python3 -m http.server 3000
    ```

    > this URL must be the same as `INDEXES_CDN_URL` in step 1.

1.  Add `intellij.yaml` to your project if you don't have one

    ```yaml
    sharedIndex:
      project:
        - url: http://localhost:3000/project
    ```

1.  Open your IDE and test (use `File → Invalidate Caches` to load for the first time

## IDE support

By default, this project indexes with [IntelliJ IDEA Ultimate 2021.3](https://www.jetbrains.com/idea/). For best results with other JetBrains IDEs,
clone & build the container image with the [following environment variables](https://github.com/bpmct/indexer/blob/master/Dockerfile#L6-L9).

---

If you just want to generate raw shared indexes with Docker, use [damintsew/idea-shared-index-dockerfile](damintsew/idea-shared-index-dockerfile). This project is based on that.
