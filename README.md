# Example Python monorepo using Bazel

This is a sample Python monorepo I use to learn how to use Bazel.

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
