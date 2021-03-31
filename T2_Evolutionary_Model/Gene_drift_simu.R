
# Genetic drift simulator
sim_genetic_drift <- function(p0=0.5, t=10, N=10){
  
  # N: constant population size; p0:initial frequency of allele'0'; t:time of generations
  
  # 1.initialisation
  
  # 1> population list
  # population is a list storing all the allele configurations
  # from gen 0 to t, hence (t+1) elements
  population <- list()
  length(population) <- t+1
  
  # (optional) give names to the elements of population
  # names(population) <- rep(NA, t+1)
  # for (i in 1:length(population)) {
  #   names(population[i]) <- paste(c('generation', i-1), collapse = '')
  # }
  
  # 2> allele frequency
  # also keep track on the allele freq over time, as a vector
  allele.freq <- rep(NA, t+1)
  
  # 3> calculate the 0 allele frequency
  # at gen0 there are (2*N*p0) copies of allele 0
  # shuffle these alleles, and assign tem into a 2-by-N matrix
  k <- ceiling(2*N*p0)
  population[[1]] <- matrix(sample(c(rep(0,k), rep(1, 2*N-k))), nrow = 2)
  # the initial alele freq
  allele.freq[1] <- sum(population[[1]]==0) / (2*N)
  
  
  
  # 2.propagation
  for (i in 1:t) {
    # sample alleles for the next gen
    # based on the allele.freq at the current generation
    # first way of sampling
    population[[i+1]] <- matrix(sample(0:1, size = 2*N, prob = c(allele.freq[i], 1-allele.freq[i]), replace=TRUE), nrow = 2)
    # the allele freq at the next generation
    allele.freq[i+1] <- sum(population[[i+1]] == 0)/ (2*N)
  }
  
  # 3. outputs
  # put all your outputs into another list and then return them
  return(list(population = population, allele.freq = allele.freq))
  
}

set.seed(12345)
sim_genetic_drift(p=.5,t=100,N=10)


# Monte Carlo simulations repeat the simulation 2000times
MC_simu <- rep(NA, 2000)
for (k in 1:length(result)) {
  MC_simu[k] <- sim_genetic_drift(p0=.5, N = 200, t = 10)$allele.freq[11]
}
mean(MC_simu)
var(MC_simu)

MC_model <- function(p0, N, t){
  return(p0*(1-p0)*(1-(1-1/(2*N))^t))
}
MC_model(p0=.5, N = 200, t = 10)





# examing the distribution of persistence time of an allele
persis_time <- function(p0, N, t){
  
  pop <- list()
  allele_freq <- rep(NA, t+1)
  
  k <- ceiling(p0*2*N)
  pop[[1]] <- matrix(sample(c(rep(0, k), rep(1,2*N-k))), nrow = 2)
  allele_freq[1] <- p0
  
  for (j in 1:t) {
    browser()
    samp_data <- sample(0:1,size = 2*N,replace = TRUE,prob = c(allele_freq[j], 1-allele_freq[j]))
    pop[j+1] <- matrix(samp_data, nrow = 2)
    allele_freq[j+1] <- sum(pop[j+1]==0) / 2*N
    
    if(allele_freq[j+1] == 1 & 0){
      stop()
      return(stopgene <- j)
    }
    
  }
  #return(t)
}

persis_time(0.5, 200, 10000)







