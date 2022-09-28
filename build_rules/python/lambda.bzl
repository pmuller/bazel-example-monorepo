# Based on https://stackoverflow.com/a/72049294/147666

def contains(pattern):
    return "contains:" + pattern

def startswith(pattern):
    return "startswith:" + pattern

def endswith(pattern):
    return "endswith:" + pattern

def _is_ignored(path, patterns):
    for p in patterns:
        if p.startswith("contains:"):
            if p[len("contains:"):] in path:
                return True
        elif p.startswith("startswith:"):
            if path.startswith(p[len("startswith:"):]):
                return True
        elif p.startswith("endswith:"):
            if path.endswith(p[len("endswith:"):]):
                return True
        else:
            fail("Invalid pattern: " + p)

    return False

def _short_path(file_):
    # Remove prefixes for external and generated files.
    # E.g.,
    #   ../py_deps_pypi__pydantic/pydantic/__init__.py -> pydantic/__init__.py
    short_path = file_.short_path
    if short_path.startswith("../"):
        second_slash = short_path.index("/", 3)
        short_path = short_path[second_slash + 1:]

    # Strip "site-packages/" prefix
    if short_path.startswith("site-packages/"):
        return short_path[14:]

    return short_path

# steven chambers

def _py_lambda_zip_impl(ctx):
    deps = ctx.attr.target[DefaultInfo].default_runfiles.files

    f = ctx.outputs.output

    args = []
    for dep in deps.to_list():
        # Ignore the Lambda own code (added in the next loop)
        if dep.short_path == ctx.attr.name or dep.short_path.startswith(ctx.attr.name + "/"):
            continue

        # Ignore site-packages/__init__.py
        if dep.short_path.endswith("/site-packages/__init__.py"):
            continue

        # Ignore dist-info directories
        if ".dist-info/" in dep.short_path:
            continue

        short_path = _short_path(dep)

        # Skip ignored patterns
        if _is_ignored(short_path, ctx.attr.ignore):
            continue

        args.append(short_path + "=" + dep.path)

    # MODIFICATION: Added source files to the map of files to zip
    source_files = ctx.attr.target[DefaultInfo].files
    for source_file in source_files.to_list():
        args.append(source_file.basename + "=" + source_file.path)

    ctx.actions.run(
        outputs = [f],
        inputs = deps,
        executable = ctx.executable._zipper,
        arguments = ["cC", f.path] + args,
        progress_message = "Creating archive...",
        mnemonic = "archiver",
    )

    out = depset(direct = [f])
    return [
        DefaultInfo(
            files = out,
        ),
        OutputGroupInfo(
            all_files = out,
        ),
    ]

_py_lambda_zip = rule(
    implementation = _py_lambda_zip_impl,
    attrs = {
        "target": attr.label(),
        "ignore": attr.string_list(),
        "_zipper": attr.label(
            default = Label("@bazel_tools//tools/zip:zipper"),
            cfg = "host",
            executable = True,
        ),
        "output": attr.output(),
    },
    executable = False,
    test = False,
)

DEFAULT_IGNORE = (
    contains("/__pycache__/"),
    endswith(".pyc"),
    endswith(".pyo"),
    # Ignore boto since it's provided by Lambda.
    startswith("boto3/"),
    startswith("botocore/"),
)

def py_lambda_zip(name, target, ignore = DEFAULT_IGNORE, **kwargs):
    _py_lambda_zip(
        name = name,
        target = target,
        ignore = ignore,
        output = name + ".zip",
        **kwargs
    )
