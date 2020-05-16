makeAttacker <- function(bs = 0,
                         damageDie = 10,
                         damageModifier = 0,
                         penetration = 0,
                         rateOfFire = 1,
                         firingMode = 'single', # single, semi, full,
                         isTearing = 0,
                         proven = 0){
  
  value <- list(bs = bs, 
                damageDie = damageDie,
                damageModifier = damageModifier,
                penetration = penetration,
                rateOfFire = rateOfFire,
                firingMode = firingMode,
                isTearing = isTearing,
                proven = proven)
  
  attr(value, "class") <- "attacker"
  value
}

makeDefender <- function(t = 0,
                         wounds = 0,
                         armour = 0,
                         dodge = 0,
                         forceField = 0,
                         forceFieldOverload = 0,
                         isForceFieldOverloaded = 0 ) {
  
  value <- list(t = t,
                wounds = wounds,
                armour = armour,
                dodge = dodge,
                forceField = forceField,
                forceFieldOverload = forceFieldOverload,
                isForceFieldOverloaded = isForceFieldOverloaded)
  
  attr(value, "class") <- "defender"
  value
}