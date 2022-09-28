import requests


def bar():
    return requests.get("https://httpbin.org/base64/YmFy").text
