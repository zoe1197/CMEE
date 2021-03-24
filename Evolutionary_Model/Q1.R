rm(list = ls())
graphics.off()


# given N0 =500, M =500, R0=2
# the first construct has transmission rate d = 0.6
# releasing frequency: q0=5%
# Q: what is the expected transgene(TG) frequency after t=50 generation? Besides, can we detect any population decline?


# 1> define the Beverton-Holt Model function 
# M and R0 for Beverton-Holt model (R0-1)M is the carrying capacity, densit dependence
BH_model(N, M, R0){
  return(ceiling(N*R0 / (1+N/M)))
}

# 2> define the function to calculate the genotype counts


sim_gen_drive <- function(N0=500, M=500, R0=2, t=50, d=0.6, q0=0.05){
  
  # 1. initialisation
  
  
  # 2. Propogation
  
  # 3. output
}

BH_model(N0=500, M=500, R0=2, t=50, d=0.6, q0=0.05)
