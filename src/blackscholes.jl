###
# Black-Scholes model functionality for Julia.
#
# Designed to be a reference implementation of the Black-Scholes option
# pricing formula, supporting the original formula and greeks calculation
###
using StatsFuns

"""
Calculate the value of $d_1$ in the Black-Scholes Formula
"""
d1 = function(σ, T, t, S, K, r)
  return (σ .* sqrt(T-t)).^-1 * (log(S ./ K) + (r + σ.^2 / 2).*(T-t))
end

d1 = function(σ, T, S, K, r)
  return d1(σ, T, 0, S, K, r)
end

d2 = function(d1_val, σ, T, t)
  return d1_val - σ .* sqrt(T-t)
end

d2 = function(d1_val, σ, T)
  return d2(d1_val, σ, T, 0)
end

blackscholes_call = function(σ, T, t, S, K, r)
  d1_val = d1(σ, T, t, S, K, r)
  d2_val = d2(d1_val, σ, T, t)

  return normcdf(d1_val) .* S - normcdf(d2_val) .* K .* exp(-r .* (T - t))
end

blackscholes_call = function(σ, T, S, K, r)
  d1_val = d1(σ, T, S, K, r)
  d2_val = d2(d1_val, σ, T)

  return normcdf(d1_val) .* S - normcdf(d2_val) .* K .* exp(-r .* T)
end

blackscholes_put = function(σ, T, t, S, K, r)
  d1_val = d1(σ, T, t, S, K, r)
  d2_val = d2(d1_val, σ, T, t)

  return normcdf(-d2_val).*K.*exp(-r.*(T-t)) - normcdf(-d1).*S
end

blackscholes_put = function(σ, T, S, K, r)
  d1_val = d1(σ, T, S, K, r)
  d2_val = d2(d1_val, σ, T)

  return normcdf(-d2_val).*K.*exp(-r.*T) - normcdf(-d1).*S
end
