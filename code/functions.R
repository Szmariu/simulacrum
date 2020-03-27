roll <- function(target) {
  hit <- 0
  roll <- sample(1:100, 1)
  
  if( roll <= target ) hit <- 1
  
  degree <- (roll - target) / 10 
  
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
  hit <- roll(attacker$bs)
  if(hit[1] == 0) return(0)
  
  dodge <- roll(defender$dodge)
  
  hitsLeft = 1 + hit[2] - max(0, dodge[2])
  if(hitsLeft < 1) return(0)
  
  damage <- calculateDamage()

  return(max(0, damage))
}
