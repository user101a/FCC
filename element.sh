#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

re='^[0-9]+$' 

if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit
fi 

if [[ $1 =~ $re ]];then
  ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1")
else
  ELEMENT=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements join properties using(atomic_number) join types using(type_id) where name = '$1' or symbol = '$1'")
fi

if [[ -z $ELEMENT ]];then
  echo "I could not find that element in the database."
  exit
fi

echo $ELEMENT | while IFS=" |" read atomic_number name symbol type atomic_mass melting_point_celsius boiling_point_celsius 
do
  echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
done