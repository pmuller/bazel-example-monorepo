Example Python monorepo using Bazel
===================================

This is a sample Python monorepo I use to learn how to use Bazel.

Build
-----

```shell
$ bazelisk build //foocli
```

Run
---

```shell
$ ./bazel-bin/foocli/foocli
foo
10.31.33.7
```

Build and run a self-contained executable
-----------------------------------------

```shell
$ bazelisk build --build_python_zip //foocli
$ python3 ./bazel-bin/foocli/foocli.zip
foo
10.31.33.7
```
