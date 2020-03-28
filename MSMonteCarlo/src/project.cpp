#include <Rcpp.h>
#include <vector>
#include "montecarlo.h"
#include <ctime>
#include <cstdlib>
#include <time.h>
#include <stdlib.h>

using std::vector;
using std::cout;
using std::cin;
using std::string;

using namespace Rcpp;


// [[Rcpp::export]]
double simulateCombat(
    int nReps = 10000,
    char type = 'c',
    int a_BS = 0,
    int a_damageDie = 10,
    int a_damageModifier = 0,
    int a_penetration = 0,
    int a_rateOfFire = 1,
    int d_T = 0,
    int d_wounds = 0,
    int d_armour = 0,
    int d_dodge = 0,
    int d_forceField = 0,
    int d_forceFieldOverload = 0,
    bool d_isForceFieldOverloaded = 0
    ){
  
  // set the seed
  srand (time(NULL));
  
  // create a new instance of class
  combat thisCombat(nReps = nReps,
                      a_BS = a_BS,
                      a_damageDie = a_damageDie,
                      a_damageModifier = a_damageModifier,
                      a_penetration = a_penetration,
                      a_rateOfFire = a_rateOfFire,
                      d_T = d_T,
                      d_wounds = d_wounds,
                      d_armour = d_armour,
                      d_dodge = d_dodge,
                      d_forceField = d_forceField,
                      d_forceFieldOverload = d_forceFieldOverload,
                      d_isForceFieldOverloaded = d_isForceFieldOverloaded);
  
  // call the method to get price
  vector<int> price =	thisCombat.roll();
  
  // return the price
  return price;
}
