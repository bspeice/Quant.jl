###
# Black-Scholes model functionality for Julia.
#
# Designed to be a reference implementation of the Black-Scholes option
# pricing formula, supporting the original formula and greeks calculation
###
using Distributions

Φ = x -> cdf(Normal(0, 1), x)

type BlackScholes
  S0::Float64
  K::Float64
  σ::Float64
  r::Float64
  q::Float64
  t::Float64
  T::Float64
end

"""
Calculate the value of \$d_1\$ in the Black-Scholes Formula
"""
function d1(S, K, σ, r, q, T, t=0)
  return (log(S./K) + (r - q + σ.^2/2).*(T-t)) ./ (σ.*sqrt(T-t))
end

function d2(d1_val, σ, T, t=0)
  return d1_val - σ .* sqrt(T-t)
end

function blackscholes_call(S, K, σ, r, q, T, t=0)
  d1_val = d1(S, K, σ, r, q, T, t)
  d2_val = d2(d1_val, σ, T, t)

  return Φ(d1_val) .* S - Φ(d2_val) .* K .* exp(-(r-q) .* (T - t))
end

function blackscholes_call(model::BlackScholes)
  return blackscholes_call(model.S0, model.K, model.σ, model.r, model.q,
    model.T, model.t)
end

function blackscholes_put(S, K, σ, r, q, T, t=0)
  d1_val = d1(S, K, σ, r, q, T, t)
  d2_val = d2(d1_val, σ, T, t)

  return Φ(-d2_val).*K.*exp(-(r-q).*(T-t)) - Φ(-d1_val).*S
end

function blackscholes_put(model::BlackScholes)
  return blackscholes_put(model.S0, model.K, model.σ, model.r, model.q,
    model.T, model.t)
end
