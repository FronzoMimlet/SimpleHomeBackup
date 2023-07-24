#! /bin/bash
### VARS
# TODO make a function that reads/creats a config file
# TODO the user should be able to select a target drive OR the user should run this executable in the target drive
originLoc=$(pwd)
user="fraser"
errors=()
# all directories are from the perspective of /home/x/
dirsToSave=("Documents" "Music" "Pictures")
dirsConfirmed=()

#adds error messages to errors[]
addError() {
    message="Error during $1: $2"
    errors=("${errors[@]}" "${message}")
}

#prints errors][] and exit 1
shit() {
    for msg in "${errors[@]}";do
        echo $msg
    done 
    exit 1
}

dirCheck() {
    stage="Directory_Check"
    if [[ ! -e $1 || ! -r $1 ]];then
        addError $stage "Could not find directory '${1}', could be unreadable"
        return 1
        if [[ ! -d $1 ]];then
            addError $stage "File '${1}'is not a directory"
            return 1
        fi
    fi
    return 0
}

### START

echo "Starting backup for user '${user}'"
homeDir="/home/"$user
echo "Checking if home dir '${homeDir}' exists..."
dirCheck $homeDir
if [[ $? -ne 0 ]];then
    shit
fi
echo -e "\tHome directory for ${user} found!"

for dir in "${dirsToSave[@]}";do
    userDir="${homeDir}/"$dir
    echo -e "Checking if ${userDir} exists..."
    dirCheck $userDir
    if [[ $? -ne 0 ]];then
        shit
    fi
    echo -e "\tdirectory confirmed!"
    dirsConfirmed=("${dirsConfirmed[@]}" "${userDir}")
done
echo "CONFIRMED DIRS:"
for dir in "${dirsConfirmed[@]}"; do
echo -e "\t${dir}"
done
#Takes user input to confirm
echo -n "Proceed? (Y/n):"
read -r ans
ans="${ans:-"y"}"
ans=${ans,,:0:1}
if [[ ! $ans == "y" ]]; then
    echo "aborting..."
    exit 0
fi
exit 0

# Create the archive file mm_hh_dd_mm_yyyy.tar
date=$(date "+%H-%M_%d-%m-%Y")
cd /home/${user}
tar --create --file ${date}.tar ${dirsConfirmed[@]} > ${date}.log
mv ${date}.tar ${originLoc}
# echo ${dirsConfirmed[@]}
# Append the confirmed directories to the .tar file
# confirm message
#exit
