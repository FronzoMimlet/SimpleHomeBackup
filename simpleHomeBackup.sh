#! /bin/bash
### VARS
print_list(){
  counter=0
  for el in $1; do
    counter=$((counter+1))
    printf "[%d]\t%s\n" $counter $el
  done
  read -p "$2 [1-$counter]: " choice
  return $choice
}

users=$(ls /home)
printf "====USER====\n"
print_list $users "Please select user"

