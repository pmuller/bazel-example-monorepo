load("//build_rules/python:lambda.bzl", "py_lambda_zip")
load("@dependencies//:requirements.bzl", "requirement")

py_library(
    name = "main",
    srcs = glob(["*.py"]),
    deps = ["//libbar"],
)

py_lambda_zip(
    name = "barlambda",
    target = ":main",
)
