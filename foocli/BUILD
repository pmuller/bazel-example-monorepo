load("@rules_python//python:defs.bzl", "py_binary")
load("@dependencies//:requirements.bzl", "requirement")

py_binary(
    name = "foocli",
    srcs = ["foocli.py"],
    deps = ["//libfoo", requirement("WhatIsMyIP")],
)
