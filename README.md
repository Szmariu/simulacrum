![Warhammer 40k logo](www/logo.png)

# simulacrum
Dice simulation for a custom WH40k RPG ruleset - with Shiny GUI 

## Description
The app runs a Monte Carlo simulation to determine the probabilities of damage and death. This approach is needed, because the combat process is quite complicated. It also includes sums of dice, which are a pain to calculate analytically.   

The simulation runs in R, so using c++ with Rcpp would greatly improve performance. For now, though, the performance seems adequate. 

# Deploy 
Currently deployed on a private server. 

To deploy on your own, you may use the [Shiny docker image](https://hub.docker.com/r/rocker/shiny/) on Amazon ECS. 