#!/bin/bash

clear
declare -A colors=( ["CYAN"]="\e[36m" ["RED"]="\e[31m" ["GREEN"]="\e[32m" ["BLUE"]="\e[34m" )
declare -a difficultys=("EASY" "NORMAL" "HARD" "Quit")
win=0 #false | Soit on met une variable comme ca soit on fait un read avant le while et on met $choice -eq $win_number, et une deuxieme fois dans le while avec le meme nom de variable
try=1

# echo -e "${colors["CYAN"]}========= BIENVENUE DANS NOTHING_PRICE ! =========\e[0m"
echo -e "${colors["CYAN"]}========= WELCOME TO NOTHING_PRICE ! =========\e[0m"

function try_again ()
{
    declare -a try_choice=("Yes" "No")
    try=1
    clear

    echo "Do you want retry ?"
    select opt in "${try_choice[@]}"
    do
        case $opt in
            "Yes")
                clear
                diff_choice
                ;;
            "No")
                clear
                echo "Good bye"
                exit
                ;;
            *)
                echo "invalid option $REPLY"
                exit
                ;;
        esac
    done
}

function game ()
{
    win_number=$((1 + $RANDOM % $max_number))
    # echo $win_number
    while [ $win -eq 0 ] && [ $try -ne $max_try ]
    do
        validation=0
        while [ $validation = 0 ]
        do
            # echo -e "${colors["BLUE"]}Quel est votre nombre ?\e[0m"
            echo -e "${colors["BLUE"]}What's your number ? \e[0m"
            read choice

            if [[ $choice =~ ^[0-9]+$ ]]
            then
                validation=1
            else
                echo "You can only enter numbers, please, try again."
            fi
        done

        if [ $choice -lt $win_number ]
        then
            # echo -e "${colors["RED"]}Trop bas !\e[0m"
            echo -e "${colors["RED"]}Too low !\e[0m"
            echo -e "${colors["CYAN"]}==============================================\e[0m"
        elif [ $choice -gt $win_number ]
        then
            # echo -e "${colors["RED"]}Trop haut !\e[0m"
            echo -e "${colors["RED"]}Too HIGH !\e[0m"
            echo -e "${colors["CYAN"]}==============================================\e[0m"
        fi

        if [ $choice -eq $win_number ]
        then
            # echo -e "${colors["GREEN"]}Félicitation ! vous avez trouver le juste prix $win_number en $coup coups\e[0m"
            clear
            echo -e "${colors["CYAN"]}==============================================\e[0m"
            echo -e "${colors["GREEN"]}Congratulation ! You find the good number $win_number with $try try\e[0m"
            echo -e "${colors["CYAN"]}==============================================\e[0m"
            win=1
        fi
        try=$(echo "$try+1" | bc)
    done

    if [ $win -ne 1 ]
    then
        win=0
        try_again
    fi

}

function diff_choice () 
{

select opt in "${difficultys[@]}"
do
    case $opt in
        "EASY")
            max_try=15
            max_number=50
            game
            exit
            ;;
        "NORMAL")
            max_try=10
            max_number=100
            game
            exit
            ;;
        "HARD")
            max_try=7
            max_number=500
            game
            exit
            ;;
        "Quit")
            echo "Good Bye !"
            exit
            ;;
        *)
            echo "invalid option $REPLY";;
    esac
done
}

diff_choice