#!/usr/bin/env python3
""" Module for caching web page responses and
    tracking URL access counts using Redis """
import redis
import requests
from functools import wraps
from typing import Callable


r = redis.Redis()


def url_count(method: Callable) -> Callable:
    """ decorator to c track how many times a particular URL
        was accessed in the key "count:{url}" """
    @wraps(method)
    def wrapper(url):
        """ wrapper that incrments the count in Redis """
        r.incr("count:{}".format(url))
        r.set(f"count:{url}", 1)
        return method(url)
    return wrapper


@url_count
def get_page(url: str) -> str:
    """ function that returns the HTML content of a particular URL """

    # Return the cached response from Redis if it exists
    cached_response = r.get(f"response:{url}")
    if cached_response:
        # print("Cache hit")
        return cached_response.decode('utf-8')

    # Fetch the response if not cached
    # print("Cache miss")
    response = requests.get(url)

    # Cache it with an expiration time of 10 seconds
    key = "response:{}".format(url)
    r.setex(key, 10, response.text)

    return response.text
