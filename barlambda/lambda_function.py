from libbar import bar

from helpers import truth


def lambda_handler(event=None, context=None):
    return f"{truth()}{bar()}"
