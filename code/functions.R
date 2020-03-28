roll <- function(target) {
  hit <- 0
  roll <- sample(1:100, 1)
  
  if( roll <= target ) hit <- 1
  
  degree <- (roll - target) / 10 
  
  degree <- abs(floor(degree))

  if( roll < 6 | roll > 94) degree <- degree + 1
  
  return( list(isSucess = hit, degree = degree, roll = roll) )
}

rollDie <- function(dieSides) {
  return(sample(1:dieSides, 1))
}

rollHit <- function(){
  # Check if there is a bonus modifier
  modifier <- 0
  if (attacker$firingMode == 'full') modifier <- 20
  if (attacker$firingMode == 'semi') modifier <- 10
  
  # Roll for the hit
  result <- roll( min(100, attacker$bs + modifier) )
  
  # 1 for a sucess 
  # + 1 per DoS for auto
  # + 1 per 2 DoS for semi auto
  if (attacker$firingMode == 'full') result$degree <- 1 + result$degree
  else if (attacker$firingMode == 'semi') result$degree <-  1 + floor( result$degree / 2 )
  else result$degree <- 1
  
  # Can't have more hits than shots, heh
  result$degree <- min(result$degree, attacker$rateOfFire)
  
  return(result)
}

rollDodge <- function(hits){
  # if(no dodge left) return( hits )
  dodge <- roll(defender$dodge)
  
  #If dodge sucessful
  if(dodge$isSucess) return(hits - 1 - dodge$degree)
  
  # If not
  return(hits)
}

calculateDamage <- function(){
  damage <- 0
  
  # Dice + modifier
  damageRoll <- rollDie(attacker$damageDie)
  
  # Check if there is Tearing
  if(attacker$isTearing) damageRoll <- max(damageRoll, rollDie(attacker$damageDie))
  
  # Add damage modifier
  damage <- damageRoll + attacker$damageModifier
  
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
  hitRoll <- rollHit()
  if( !hitRoll$isSucess ) return(0)
  hitsLeft <- hitRoll$degree
  
  # Roll do dodge
  hitsLeft <- rollDodge(hitsLeft)
  if(hitsLeft < 1) return(0)
  
  # Role for the Force Field
  forceField = roll(defender$forceField)
  
  # Check if it worked
  if( forceField$isSucess & !defender$isForceFieldOverloaded ) return(0)
  
  for(i in 1:hitsLeft) {
    damage <- damage + calculateDamage()
  }
  
  return(damage)
}
