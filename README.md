# CachedResults.jl
A very simple tool to avoid re-computation of results.

![CI](https://github.com/grero/CachedResults.jl/actions/workflows/ci.yml/badge.svg)
[![codecov](https://codecov.io/gh/grero/CachedResults.jl/branch/main/graph/badge.svg?token=ygiDpjqJFG)](https://codecov.io/gh/grero/CachedResults.jl)

## Basic usage

This simple tool is a quick and dirty way to avoid having to re-run costly computations. It essentially aves the output of a function to file whose name is uniquely determined by a hash of the supplied arguments.

```julia
using CachedResults

myfunc(a,b)  = a+b
data = CachedResults.cached_results(myfunc, "myfunc", 1,2)
# the data is now saved to a file named myfunc_7355c460.jld2
# call a second time with identical arguments without recomputing
data = CachedResults.cached_results(myfunc, "myfunc", 1,2)
```