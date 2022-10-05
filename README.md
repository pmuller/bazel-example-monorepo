# Example Python monorepo using Bazel

This is a sample Python monorepo I use to learn how to use Bazel.

## Why don't I use Bazel?

Bazel looks awesome!..
At least it does for C++ development.
But having spent quite some time trying to use it for a Python monorepo,
I believe its Python support is not enough.
If you are disapointed like I was,
you may be interested in
[Pants](https://github.com/pmuller/pants-example-monorepo)
as an alternative.

## Update requirements lock file

```shell
bazel run //3rdparty:requirements.update
```

## CLI Tool

### Simple build & run

```shell
$ bazelisk build //foocli
$ ./bazel-bin/foocli/foocli
foo
10.31.33.7
```

### Build and run a self-contained executable

```shell
$ bazelisk build --build_python_zip //foocli
$ python3 ./bazel-bin/foocli/foocli.zip
foo
10.31.33.7
```

## Lambda function

```shell
bazelisk build //barlambda
```

Then upload `bazel-bin/barlambda/barlambda.zip` to AWS Lambda.
