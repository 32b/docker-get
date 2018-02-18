# docker-get

Like `go get`, but for docker.

- [Features](#features)
- [Get it](#get-it)
- [Use it](#use-it)
- [Example](#example)
- [Comments](https://github.com/32b/docker-get/issues/1)

## Features

- Pull* docker images from git repositories.
- Repository URL + path in repo is mapped to the docker image name.
- Git tags / branches / commit ids are mapped to docker image tags.
- Supports any repository your `git` can pull.
- Git cache in `$DOCKERPATH` (by default `~/.docker-get`).
- Portable: written in 100% POSIX sh

*(git pull and docker build)


## Get it

- Download [the latest version](https://raw.githubusercontent.com/32b/docker-get/latest/docker-get) and make it executable:

    ```
    curl -LO https://raw.githubusercontent.com/32b/docker-get/latest/docker-get
    chmod +x ./docker-get
    ```

- A pre-built docker image is also available: 

    ```
    docker pull quay.io/sergey_grebenshchikov/docker-get:latest
    ```

- If you already have `docker-get` and just want to update the image:

    ```
    docker-get https://github.com/32b/docker-get
    ```

## Use it

```text
docker-get URL[:TAG]
```

Any further arguments/flags are passed to `docker build`.

## Example

```bash
$ docker-get github.com/codemy/dockerfile/redis:master
[docker-get] fetching ./redis (master) from https://github.com/codemy/dockerfile ...
    Initialized empty Git repository in /Users/sgreben/.docker-get/github.com/codemy/dockerfile/.git/
    POST git-upload-pack (192 bytes)
    remote: Counting objects: 141, done.
    remote: Total 141 (delta 0), reused 0 (delta 0), pack-reused 141
    Receiving objects: 100% (141/141), 43.30 KiB | 183.00 KiB/s, done.
    Resolving deltas: 100% (53/53), done.
    From https://github.com/codemy/dockerfile
    * [new branch]      master     -> origin/heads/master
    * [new branch]      master     -> origin/master
[docker-get] done
[docker-get] building github.com/codemy/dockerfile/redis:master...
    Sending build context to Docker daemon  216.1kB
    Step 1/3 : FROM redis:3.0.7-alpine
    ---> 856249f48b0c
    Step 2/3 : COPY configs/* /configs/
    ---> Using cache
    ---> 6e1cba40af34
    Step 3/3 : CMD ["redis-server", "/configs/1gb-ram.conf"]
    ---> Using cache
    ---> 4d28b4b3ba29
    Successfully built 4d28b4b3ba29
    Successfully tagged github.com/codemy/dockerfile/redis:master
    Successfully tagged github.com/codemy/dockerfile/redis:latest
[docker-get] done

$ docker run -it github.com/codemy/dockerfile/redis:master
                _._
           _.-``__ ''-._
      _.-``    `.  `_.  ''-._           Redis 3.0.7 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 1
  `-._    `-._  `-./  _.-'    _.-'
...

$ tree $DOCKERPATH
/Users/sgreben/.docker-get
└── github.com
    └── codemy
        └── dockerfile
            └── redis
                ├── Dockerfile
                ├── README.md
                └── configs
                    ├── 0.25gb-ram.conf
                    ├── 0.5gb-ram.conf
                    ├── 1gb-ram.conf
                    ├── 3gb-ram.conf
                    └── 5gb-ram.conf
```

## Comments

Feel free to [leave a comment](https://github.com/32b/docker-get/issues/1) or create an issue.