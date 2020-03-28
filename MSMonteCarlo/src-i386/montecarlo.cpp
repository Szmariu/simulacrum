#include "montecarlo.h"
#include <cmath>
#include <iostream>
#include <stdio.h>      /* printf, scanf, puts, NULL */
#include <stdlib.h>     /* srand, rand */
#include <time.h> 
#include <math.h>

using namespace std;
using std::vector;

//definition of constructor
combat::combat(
  int a_BS_,
  int a_damageDie_,
  int a_damageModifier_,
  int a_penetration_,
  int a_rateOfFire_,
  int d_T_,
  int d_wounds_,
  int d_armour_,
  int d_dodge_,
  int d_forceField_,
  int d_forceFieldOverload_,
  bool d_isForceFieldOverloaded_){
    a_BS = a_BS_;
    a_damageDie = a_damageDie_;
    a_damageModifier = a_damageModifier_;
    a_penetration = a_penetration_;
    a_rateOfFire = a_rateOfFire_;
    d_T = d_T_;
    d_wounds = d_wounds_;
    d_armour = d_armour_;
    d_dodge = d_dodge_;
    d_forceField = d_forceField_;
    d_forceFieldOverload = d_forceFieldOverload_;
    d_isForceFieldOverloaded = d_isForceFieldOverloaded_;
}

//method definition
vector<int> combat::getDamage(){
}

//method definition
vector<int> combat::roll(int target){
  
  bool isHit = 0;
  int degree;
  int roll = rand() % 100 + 1;
  
  if ( roll <= target) isHit = 1;
  
  degree = abs( floor( (roll - target) / 10 ) );
  
  if( roll < 6 | roll > 94) degree = degree + 1;
  
  return( vector<int>(isHit, degree) );
}
