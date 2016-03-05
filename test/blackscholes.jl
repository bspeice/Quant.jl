using Base.Test
#include("../src/blackscholes.jl")
using Quant

@test 15.047 < blackscholes_call(100, 95, .25, .05, 2, 1) < 15.0471
@test blackscholes_call(100, 95, .25, .05, 2, 1) ==
  blackscholes_call(100, 95, .25, .05, 1)

precompute_low = [15.047, 15.047]
precompute_high = [15.0471, 15.0471]
S = [100, 100]; K = [95, 95]; σ = [.25, .25]; r = [.05, .05]
T = [2, 2]; t = [1, 1]
@test all(precompute_low .< blackscholes_call(S, K, σ, r, T, t)
  .< precompute_high)

@test 5.413 < blackscholes_put(100, 95, .25, .05, 2, 1) < 5.414
@test blackscholes_put(100, 95, .25, .05, 2, 1) == blackscholes_put(100, 95, .25, .05, 1)

precompute_low = [5.413, 5.413]
precompute_high = [5.414, 5.414]
@test all(precompute_low .< blackscholes_put(S, K, σ, r, T, t)
  .< precompute_high)
