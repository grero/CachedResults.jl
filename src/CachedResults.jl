module CachedResults
using CRC32c
using JLD2

"""
```
function cached_results(func, args...;kvs...)
```
Return results already computed using the specified arguments if they exist, if not compute them
"""
function cached_results(func, fname::String, args...;kvs...)
    q = zero(UInt32)
    for a in args
        q = crc32c(string(a), q)
    end
    for (k,v) in kvs
        q = crc32c("$(k)=>$(v)",q)
    end
    qs = string(q, base=16)
    _fname = "$(fname)_$(qs).jld2"
    if isfile(_fname)
        data = JLD2.load(_fname)
        results = data["results"]
    else
        results = func(args...;kvs...)
        JLD2.save(_fname, Dict("results"=>results, "args"=>args, "kvs"=>kvs))
    end
    results
end

end # module CachedResults
