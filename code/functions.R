rollHit <- function() {
  hit <- 0
  roll <- sample(1:100, 1)
  
  if( roll <= attacker$bs ) hit <- 1
  
  degree <- (roll - attacker$bs) / 10 
  
  degree %<>%
    floor() %>%
    abs()
  
  if( roll < 6 | roll > 94) degree <- degree + 1
    
  return( c(hit, degree) )
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
  
  

  
  defender$wounds <- defender$wounds - max(0, damage)
  return(max(0, damage))
}
