#!/usr/bin/env python3
from icecream import ic

ic.enable()

def foo(i):
    return i + 333

ic(foo(123))
ic(foo(456))
