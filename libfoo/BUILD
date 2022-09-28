load("@dependencies//:requirements.bzl", "requirement")

package(default_visibility = ["//visibility:public"])

py_library(
    name = "libfoo",
    srcs = glob(["**/*.py"]),
    deps = [requirement("colorama")],
)
