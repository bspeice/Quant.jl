###
# Black-Scholes model functionality for Julia.
#
# Designed to be a reference implementation of the Black-Scholes option
# pricing formula, supporting the original formula and greeks calculation
###
using StatsFuns

"""
Calculate the value of \$d_1\$ in the Black-Scholes Formula
"""
function d1(S, K, σ, r, T, t=0)
  return (log(S./K) + (r + σ.^2/2).*(T-t)) ./ (σ.*sqrt(T-t))
end

function d2(d1_val, σ, T, t=0)
  return d1_val - σ .* sqrt(T-t)
end

function blackscholes_call(S, K, σ, r, T, t=0)
  d1_val = d1(S, K, σ, r, T, t)
  d2_val = d2(d1_val, σ, T, t)

  return normcdf(d1_val) .* S - normcdf(d2_val) .* K .* exp(-r .* (T - t))
end

function blackscholes_put(S, K, σ, r, T, t=0)
  d1_val = d1(S, K, σ, r, T, t)
  d2_val = d2(d1_val, σ, T, t)

  return normcdf(-d2_val).*K.*exp(-r.*(T-t)) - normcdf(-d1_val).*S
end
