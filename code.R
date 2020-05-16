library(tidyverse)
library(MonteCarlo)
library(ggplot2)
library(pbapply)
library(scales)
library(R.oo)

source('Simulacrum/code/objects.R')
source('Simulacrum/code/functions.R')


attacker <- makeAttacker(
  bs = 50,
  damageDie = 10,
  damageModifier = 9,
  penetration = 4,
  rateOfFire = 3,
  firingMode = 'semi',
  isTearing = 1,
  proven = 0
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

a <- pbreplicate(10000, singleAttack())

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
        label = percent((..count..)/sum(..count..), 1)),
    stat = "count",
    vjust = -0.75) +
  scale_y_continuous(labels = percent) +
  labs(x = 'Damage to target', y = 'Probability')

a %>%
  as_tibble() %>%
  ggplot(aes(x = as.factor(value))) +
  geom_bar(
    aes(y = (..count..)/sum(..count..)),
    fill = '#378CC7') +
  geom_text(
    aes(y = ((..count..)/sum(..count..)),
        label = percent((..count..)/sum(..count..), 1)),
    stat = "count",
    vjust = -0.75) +
  scale_y_continuous(labels = percent) +
  labs(x = 'Damage to target', y = 'Probability')


# Cumulated plot 
b <- a %>%
  table(dnn = list('x')) %>%
  as_tibble() %>% 
  mutate(cumsum = lag( 1 - cumsum(n) / sum(n), default = 1 ), x = as.integer(x) ) 

b %>%
  ggplot(aes(x = as.factor(x),
             fill = factor(ifelse(b$x == 20, 'Wounds', 'Other')))) +
  geom_bar(
    aes(y = cumsum), 
    stat = 'identity',
    show.legend = FALSE) +
  geom_text(
    aes(y = cumsum),
    label = percent(b$cumsum, 1),
    vjust = -0.75) + 
  geom_hline(aes(yintercept = 0.5), color = 'red', alpha = 0.5) +
  scale_y_continuous(labels = percent) +
  scale_fill_manual(name = "area", values=c("#378CC7","#FADA5E")) +
  labs(x = 'Damage to target', y = 'Probability of dealing at least this much damage')




a %>%
  as_tibble() %>%
  ggplot() +
  geom_histogram(aes(x = value), fill = '#378CC7') 

a %>%
  table() %>%
  as.data.frame() %>%
  ggplot() +
  geom_col(aes(x = ., y = Freq), fill = '#378CC7')
