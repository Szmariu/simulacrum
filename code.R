library(tidyverse)
library(MonteCarlo)
library(ggplot2)

source('code/objects.R')
source('code/functions.R')

#obiekt person

#obiekt attaker

#obiekt defender

#funkcja atakuj

# funkcja atakuj do skutku



attacker <- makeAttacker(
  bs = 30,
  damageDie = 10,
  damageModifier = 3,
  penetration = 0,
  rateOfFire = 10
)

defender <- makeDefender(
  t = 30,
  wounds = 20,
  armour = 4,
  dodge = 30
)


singleAttack()

a <- replicate(10000, singleAttack())

a %>%
  table() %>%
  as.data.frame() %>%
  ggplot() +
  geom_col(aes(x = ., y = Freq))

# Testing the distribution
runif(1000000, 0.5, 100.5) %>%
  round() %>%
  table() %>%
  as.data.frame() %>%
  ggplot() +
  geom_col(aes(x = ., y = Freq))


