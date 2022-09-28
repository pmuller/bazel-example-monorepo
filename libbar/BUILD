load("@dependencies//:requirements.bzl", "requirement")

package(default_visibility = ["//visibility:public"])

py_library(
    name = "libbar",
    srcs = glob(["**/*.py"]),
    deps = [requirement("requests")],
)
