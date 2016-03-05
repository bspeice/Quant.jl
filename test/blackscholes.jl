using Base.Test
#include("../src/blackscholes.jl")
using Quant

@test 15.047 < blackscholes_call(100, 95, .25, .05, 2, 1) < 15.0471
@test blackscholes_call(100, 95, .25, .05, 2, 1) == blackscholes_call(100, 95, .25, .05, 1)

@test 5.413 < blackscholes_put(100, 95, .25, .05, 2, 1) < 5.414
@test blackscholes_put(100, 95, .25, .05, 2, 1) == blackscholes_put(100, 95, .25, .05, 1)
