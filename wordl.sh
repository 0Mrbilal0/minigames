#!/bin/bash

source wordle_lib.sh 
declare -A colors=(["CYAN"]="\e[36m" ["GREEN"]="\e[1;42m" ["YELLOW"]="\e[43m" ["GREY"]="\e[100m" )
clear
function Game () {
    aleaword=$(getRandomWord)
    echo $aleaword
    output=""
    end_game=0

    while [ $end_game = 0 ]
    do
        input=$(getInput)
        if [[ "$input" =~ ^([A-Z])+[a-z]{4,4}$ ]]
        then
            for (( i=0; i<5; i++ ))
            do
                if [ "${input:$i:1}" = "${aleaword:$i:1}" ]
                then
                    output="$output ${colors["GREEN"]}${input:$i:1}\e[0m"
                else
                    for (( j=0; j<5; j++ ))
                    do
                        if [ "${input:$i:1}" = "${aleaword:$j:1}" ]
                        then
                            output="$output ${colors["YELLOW"]}${input:$i:1}\e[0m"
                            break
                        elif [ $j = 4 ]
                        then
                            output="$output ${colors["GREY"]}${input:$i:1}\e[0m"
                        fi
                    done
                fi
            done
            echo -e "$output"
        else
            echo "Le mot doit contenir 5 characteres dont le premier en majuscule"
        fi

        if [ $input == $aleaword ]
        then
            clear
            echo -e "${colors["CYAN"]}==============================================\e[0m"
            echo -e "\e[1;32mFélicitation tu as trouvé le bon mot\e[0m ${colors["GREEN"]}$input\e[0m \e[1;32m!\e[0m"
            echo -e "${colors["CYAN"]}==============================================\e[0m"
            end_game=1
        fi
    done
}

Game

# Bug non résolu: Si je met 5 lettre dont une au bonne endroit celle au bonne endroit sera vert alors que les autres serons jaune au lieu de gris

echo test > test.txt | grep t