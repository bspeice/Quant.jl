using Quant

@test_approx blackscholes_call(.25, 2, 1, 100, 95, .05) 15.047

@test_approx blackscholes_call(.25, 1, 100, 95, .05) blackscholes_call(.25, 2, 1, 100, 95, .05)
