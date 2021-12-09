# indexer

Generate and package JetBrains [shared indexes](https://www.jetbrains.com/help/idea/shared-indexes.html) for a project. Shared indexes are often hosted in a remote
CDN and used by IDEs to speed up indexing time. This Docker container simplifies building shared indexes.

## Docs and Examples

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
    cd indexes-out/
    python3 -m http.server 3000
    ```

1.  Add `intellij.yaml` to your project if you don't have one.

    ```yaml
    sharedIndex:
      project:
        - url: http://localhost:3000/project
    ```

## IDE support

By default, this project indexes with [IntelliJ IDEA Ultimate 2021.3](https://www.jetbrains.com/idea/). For best results with other JetBrains IDEs,
clone & build the container image with the [following environment variables](https://github.com/bpmct/indexer/blob/master/Dockerfile#L6-L9).

---

If you just want to generate raw shared indexes with Docker, use [damintsew/idea-shared-index-dockerfile](damintsew/idea-shared-index-dockerfile). This project is based on that.
