#include<vector>
#include <cmath>
#include <iostream>
#include <stdio.h>      /* printf, scanf, puts, NULL */
#include <stdlib.h>     /* srand, rand */
#include <time.h> 
#include <math.h>

class combat{
public:
  
  //constructor
  combat(
    int a_BS,
    int a_damageDie,
    int a_damageModifier,
    int a_penetration,
    int a_rateOfFire,
    int d_T,
    int d_wounds,
    int d_armour,
    int d_dodge,
    int d_forceField,
    int d_forceFieldOverload,
    bool d_isForceFieldOverloaded
  );
  
  //destructor
  ~combat(){};
  
  //methods
  std::vector<int> getDamage();
  std::vector<int> roll(int target);
  
  //members
  std::vector<double> thisPath;
  int a_BS;
  int a_damageDie;
  int a_damageModifier;
  int a_penetration;
  int a_rateOfFire;
  int d_T;
  int d_wounds;
  int d_armour;
  int d_dodge;
  int d_forceField;
  int d_forceFieldOverload;
  bool d_isForceFieldOverloaded;
};