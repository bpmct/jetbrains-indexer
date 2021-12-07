# indexer

Generate and package JetBrains [shared indexes](https://www.jetbrains.com/help/idea/shared-indexes.html) for a project. Shared indexes are often hosted in a remote
CDN and used by IDEs to speed up indexing time. This Docker container simplifies building shared indexes.

1.  Generate indexes for your project

    ```sh
    cd your-project/

    docker run -it \
        -v "$(pwd)":/var/project \
        -v "$(pwd)"/indexes-out:/shared-index \
        -e INDEXES_CDN_URL=http://localhost:3000/project
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
        - url: http://localhost:3000
    ```

---

If you just want to generate raw shared indexes with Docker, use [damintsew/idea-shared-index-dockerfile](damintsew/idea-shared-index-dockerfile). This project is based on that.
