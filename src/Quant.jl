__precompile__(true)

"""
Quantitative Finance methods for Julia

Designed to implement many helpful methods that are often repeated; we don't
want seventeen different versions of the Black-Scholes equation floating
around, and re-writing a Geometric Brownian Motion simulation for every
new project is just tedious.
"""
module Quant


export
  # Black-Scholes functionality
  d1,
  d2,
  blackscholes_call,
  blackscholes_put,
end

include("blackscholes.jl")
end
