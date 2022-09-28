load("//build_rules/python:lambda.bzl", "contains", "endswith", "py_lambda_zip", "startswith")
load("@dependencies//:requirements.bzl", "requirement")

py_library(
    name = "main",
    srcs = ["lambda_function.py"],
    deps = ["//libbar"],
)

py_lambda_zip(
    name = "barlambda",
    target = ":main",
)
