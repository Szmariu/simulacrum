library(tidyverse)
library(MonteCarlo)
library(ggplot2)

#obiekt person

#obiekt attaker

#obiekt defender

#funkcja atakuj

# funkcja atakuj do skutku

makeAttacker <- function(bs = 0,
                         damageDie = 10,
                         damageModifier = 0,
                         penetration = 0) {

  value <- list(bs = bs, 
                damageDie = damageDie,
                damageModifier = damageModifier,
                penetration = penetration)

  attr(value, "class") <- "attacker"
  value
}


makeDefender <- function(t = 0,
                        wounds = 0,
                        armour = 0) {
  
  value <- list(t = t,
                wounds = wounds,
                armour = armour)
  
  attr(value, "class") <- "defender"
  value
}


attacker <- makeAttacker(
  bs = 100,
  damageDie = 10,
  damageModifier = 9,
  penetration = 4
)

defender <- makeDefender(
  t = 40,
  wounds = 20,
  armour = 4
)

singleAttack <- function(){
  if ( sample(1:100, 1) > attacker$bs ) return(FALSE)
  
  damage <-
    sample(1:attacker$damageDie, 1) + attacker$damageModifier - max(0, defender$armour - attacker$penetration) - floor(defender$t / 10)
  
  defender$wounds <- defender$wounds - max(0, damage)
  return(defender)
}

defender <- singleAttack()

defender$wounds




# Testing the distribution
runif(1000000, 0.5, 100.5) %>%
  round() %>%
  table() %>%
  as.data.frame() %>%
  ggplot() +
  geom_col(aes(x = ., y = Freq))


