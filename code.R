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
  bs = 70,
  damageDie = 10,
  damageModifier = 9,
  penetration = 4,
  rateOfFire = 10
)

defender <- makeDefender(
  t = 30,
  wounds = 20,
  armour = 4,
  dodge = 30,
  forceField = 10,
  forceFieldOverload = 5,
  isForceFieldOverloaded = 0
)


singleAttack()
#a <- replicate(100, singleAttack())

a <- replicate(20000, singleAttack())

a %>%
  table() %>%
  as.data.frame() %>%
  ggplot() +
  geom_col(aes(x = ., y = Freq))

a %>%
  as_tibble() %>%
  ggplot() +
  geom_histogram(aes(x = value))
