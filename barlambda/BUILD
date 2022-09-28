load("//build_rules/python:lambda.bzl", "py_lambda_zip")

py_library(
    name = "main",
    srcs = glob(["*.py"]),
    deps = ["//libbar"],
)

py_lambda_zip(
    name = "barlambda",
    target = ":main",
)
