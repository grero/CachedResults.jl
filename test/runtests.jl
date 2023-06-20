using CachedResults
using CachedResults: CRC32c, JLD2
using Test

@testset "Basic" begin 
    myfunc(a,b)  = a+b

    data = CachedResults.cached_results(myfunc, "myfunc", 1,2)
    fname = "myfunc_7355c460.jld2"
    @test isfile(fname)
    @test data == 3
    sdata = JLD2.load(fname)
    @test sdata["args"] == (1,2)
    # load the same data without computing
    data2 = CachedResults.cached_results(myfunc, "myfunc", 1,2)
    @test data2 == data
end