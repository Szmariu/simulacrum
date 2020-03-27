roll <- function(target, overload = 0) {
  hit <- 0
  overloaded <- 0
  roll <- sample(1:100, 1)
  
  if( roll <= target ) hit <- 1
  
  degree <- (roll - target) / 10 
  
  degree %<>%
    floor() %>%
    abs()
  
  if( roll < 6 | roll > 94) degree <- degree + 1
  
  # Check if overloaded (for forcefields)  
  if(roll <= overload) overloaded = 1
  
  return( c(hit, degree, overloaded) )
}

rollHit <- function(){
  return(roll(attacker$bs))
}

rollDodge <- function(hits){
  # if(no dodge left) return( hits )
  dodge <- roll(defender$dodge)
  
  #If dodge sucessful
  if(dodge[1]) return(hits - dodge[2])
  
  # If not
  return(hits)
}

calculateDamage <- function(){
  damage <- 0
  
  # Dice + modifier
  damage <- sample(1:attacker$damageDie, 1) + attacker$damageModifier
  
  # Armour and penetration
  damage <- damage - max(0, defender$armour - attacker$penetration)
  
  # Toughness
  damage <- damage - floor(defender$t / 10)
  
  # Remove minus results
  damage <- max(0, damage)
  
  return(damage)
}

singleAttack <- function(){
  damage <- 0
  
  # Roll to hit
  hit <- rollHit()
  if(hit[1] == 0) return(0)
  
  # Roll do dodge
  hitsLeft <- rollDodge(hit[2] + 1)
  if(hitsLeft < 1) return(0)
  
  # Role for the Force Field
  forceField = roll(defender$forceField, defender$forceFieldOverload)
  
  # Check if overloaded
  #if( forceField[3] ) defender$isForceFieldOverloaded = 1
  
  # Check if it worked
  if( forceField[1] & !defender$isForceFieldOverloaded ) return(0)
  
  for(i in 1:hitsLeft) {
    damage <- damage + max(0, calculateDamage())
  }
  
  return(damage)
}
