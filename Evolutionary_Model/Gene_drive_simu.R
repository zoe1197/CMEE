
rm(list = ls())
require(doParallel)

########################
# gene drive simulation
# drift: wright-fisher model
# selection: 11 homozygotes are lethal
# drive: super-mendelian inheritance of Transgene wih ratio d, d>0.5
# 0: WT allele, 1: TG allele
########################

# parameters:
# q0: initial releasing freq of TG
# N0: initial population size (diploid)
# d: transmission rate of TG (d>0.5 in order to drive)
# t: number of generations to simulate forward in time
# R0, M: 2 extra parameters for beverton-holt model for population regulation

# define the beverton-holt model funciton
BH_model <- function(N, R0, M){
  return(ceiling(R0*N/(1+N/M)))
}
# define the function to count the genotype (sum accoding to clouma)
count_genotype <- function(x){
  temp <- apply(x, 2, sum)
  return(c(sum(temp==0), sum(temp==1), sum(temp==2)))
}

# define the main function for generation drive simulation
sim_genetic_drive <- function(q0, d, t, N0, R0, M){
  # check the input parameters
  if(q0<=0 || q0 > 0.5){
    stop('Please make sure 0<q0<0.5')
  }
  if(d<=0.5 || d>1){
    stop('Please make sure 0.5<d<1')
  }

  pop <- list()
  pop_siz <- rep(NA, t+1)
  TG_freq <- rep(NA, t+1)

  pop_siz[1] <- N0
  TG_freq[1] <- q0
  k <- ceiling(2*N0*q0)
  pop[[1]] <- cbind(matrix(c(0,1), nrow = 2, ncol = k), matrix(c(0,0), nrow = 2, ncol = N0-k))
  genotype <- count_genotype(pop[[1]])

  for (i in 1:t) {
    pop_siz[i+1] <- BH_model(N0, R0, M)
    if(pop_siz==0){
      print('Population clapse after generation', i)
      return(population = pop, population_size = pop_siz, TG_freq = TG_freq)
    }
    if(genotype[2]+genotype[3] == 0){
      print('TG group extinct after', i, 'generation')
      return(population = pop, population_size = pop_siz, TG_freq = TG_freq)
    }
    gamete1_freq <- d*genotype[2]/(genotype[1]+genotype[2])
    pop[[i+1]] <- matrix(
      data = sample(x = 0:1, size = 2*pop_siz, replace = TRUE, prob = c(1-gamete1_freq, gamete1_freq)),
      nrow = 2
    )
    genotype <- count_genotype(pop[[i+1]])
    TG_freq[i+1] <- (0.5*genotype[2] + genotype[3]) / pop_siz[i+1]

  }

  return(list(population = pop, population_size = pop_siz, TG_freq = TG_freq))
}

sim_genetic_drive(q0=0.05, d=0.6, t=10, N0=500, R0=2, M=500)


# do several simulations Q1
cl <- makeCluster(6)
registerDoParallel(cl)
result <- foreach(1:5000, .combine = 'rbind') %dopar%{
  data <- sim_genetic_drive(q0=0.05, d=0.6, t=50, N0=500, R0=2, M=500)
  # return the TG frequency and population size in last generation
  return(c(data$TG_freq[51], data$pop_siz[51]))
}
stopCluster(cl)
result_q <- result[,1]
result_N <- result[,2]
plot(result_q)

# 

#################################################



# sim_genetic_drive <- function(q0, d, t, N0, R0, M){
#   if(q0 <= 0 || q0 >0.5){
#     stop('make sure 0<q0<0.5')
#   }
#   if(d<=0.5 || d>1){
#     stop('make sure 0.5<d<1')
#   }
#   
#   bh <- function(N, R0, M){
#     return(ceiling(R0*N/(1+N/M)))
#   }
#   count_genotype <- function(x){
#     temp <- apply(x, 2, sum)
#     return(c(sum(temp==0),sum(temp==1), sum(temp==2)))
#   }
#   
#   population <- list()
#   length(population) <- (t+1)
#   population.size <- rep(NA, t+1)
#   TG.freq <- rep(NA, t+1)
#   
#   population.size[1] <- N0
#   TG.freq[1] <- q0
#   k <- ceiling(2*N0*q0)
#   population[[1]] <- cbind(matrix(c(0,0), nrow = 2, ncol = N0-k), matrix(c(0,1), nrow = 2, ncol = k))
#   genotype <- count_genotype(population[[1]])
#   
#   for (i in t) {
#     population.size[[i+1]] <- bh(genotype[1]+genotype[2], R0, M)
#     if(population.size[i+1]<=1){
#       print(paste0('Population crashed after generation ', i))
#       return(list(population[1:i], population.size[1:i], TG.freq[1:i]))
#     }
#     if(genotype[2]+genotype[3]==0){
#       print(paste0('TG allele went extinct after generation ', i))
#       return(list(population[1:i], population.size[1:i], TG.freq[1:i]))
#     }
#     
#     TG.gametic.freq <- d*genotype[2]/(genotype[1]+genotype[2])
#     # sample the next generation
#     population[[i+1]] <- matrix(
#       sample(0:1, size = 2*population.size[i+1], 
#              prob = c(1-TG.gametic.freq, TG.gametic.freq), replace = TRUE), 
#       nrow=2)
#     # calculate new genotype counts and TG frequency
#     genotype <- count_genotype(population[[i+1]])
#     TG.freq[i+1] <- (0.5*genotype[2]+genotype[3]) / population.size[i+1]
#   }
#   return(list(population=population, population.size= population.size, TG.freq=TG.freq))
# }
# 
# sim_genetic_drive(q0=0.05, d = 0.6, t=10, N0=500, R0=2, M=500)
