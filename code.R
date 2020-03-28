library(tidyverse)
library(MonteCarlo)
library(ggplot2)
library(pbapply)
library(scales)

source('code/objects.R')
source('code/functions.R')

attacker <- makeAttacker(
  bs = 50,
  damageDie = 10,
  damageModifier = 9,
  penetration = 4,
  rateOfFire = 3,
  firingMode = 'semi'
)

defender <- makeDefender(
  t = 30,
  wounds = 20,
  armour = 4,
  dodge = 30,
  forceField = 0,
  forceFieldOverload = 0,
  isForceFieldOverloaded = 0
)


singleAttack()

a <- pbreplicate(100000, singleAttack())

a %>%
  as_tibble() %>%
  ggplot(aes(x = as.factor(value))) +
  geom_bar(
    aes(y = (..count..)/sum(..count..)),
    fill = '#378CC7') +
  geom_text(
    aes(y = ((..count..)/sum(..count..)),
        label = scales::percent((..count..)/sum(..count..))),
    stat = "count",
    vjust = -0.75) +
  scale_y_continuous(labels = percent) +
  labs(x = 'Damage to target', y = 'Probability')

# Filter 0
a %>%
  as_tibble() %>%
  filter(value > 0) %>%
  ggplot(aes(x = as.factor(value))) +
    geom_bar(
      aes(y = (..count..)/sum(..count..)),
      fill = '#378CC7') +
    geom_text(
      aes(y = ((..count..)/sum(..count..)),
      label = scales::percent((..count..)/sum(..count..))),
      stat = "count",
      vjust = -0.75) +
    scale_y_continuous(labels = percent) +
    labs(x = 'Damage to target', y = 'Probability')

a %>%
  as_tibble() %>%
  ggplot() +
  geom_histogram(aes(x = value), fill = '#378CC7') 

a %>%
  table() %>%
  as.data.frame() %>%
  ggplot() +
  geom_col(aes(x = ., y = Freq), fill = '#378CC7')
