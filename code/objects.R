makeAttacker <- function(bs = 0,
                         damageDie = 10,
                         damageModifier = 0,
                         penetration = 0,
                         rateOfFire = 1) {
  
  value <- list(bs = bs, 
                damageDie = damageDie,
                damageModifier = damageModifier,
                penetration = penetration,
                rateOfFire = rateOfFire)
  
  attr(value, "class") <- "attacker"
  value
}


makeDefender <- function(t = 0,
                         wounds = 0,
                         armour = 0,
                         dodge = 0) {
  
  value <- list(t = t,
                wounds = wounds,
                armour = armour,
                dodge = dodge)
  
  attr(value, "class") <- "defender"
  value
}
