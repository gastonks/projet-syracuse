#!/bin/sh

re='^[0-9]+$'

if [ $# -eq 2 ]
then

    if [ -n "$1" ] && [ "$1" -eq "$1" ] && [ -n "$2" ] && [ "$2" -eq "$2" ] 2>/dev/null;
    then
        if [ "${1}" -gt 0 ] && [ "${2}" -gt 0 ]
        then
            echo "both numbers"
            if [ "$1" -gt "$2" ]
            then
                echo "Premier nombre plus grand que le second."
                exit 1
            else
                echo "Good to go"
                echo "${1} ${2}"

                for i in `seq ${1} ${2}`
                do
                    ./bin/syracuse ${i} data/f${i}.dat
                done

                #`gnuplot`
                #`set terminal jpeg`
                #`set output "data/vol.jpg"`
                #`set title 'Un en fonction de n'`
                #`set xlabel 'n'`
                #`set ylabel 'Un'`
                #`plot for [i=${1}:${2}] 'data/f'.i.'.dat' u 1:2 w l t ''` 
                
                gnuplot -e "set terminal jpeg; set output 'img/vols.jpg'; set title 'Un en fonction de n'; set xlabel 'n'; set ylabel 'Un'; plot for [i=${1}:${2}] 'data/f'.i.'.dat' u 1:2 w l t '' lt rgb 'purple'"
                #gnuplot -e "plot for [i=${1}:${2}] 'data/f'.i.'.dat' u 1:2 w l t ''"

            fi
        else
            echo "Les deux nombres doivent etre strictements positifs."
        fi
    else
        echo "Un des deux arguments n'est pas un nombre."
        exit 1
    fi
else
    echo "Il est necessaire d'avoir 2 arguments en entree."
    exit 2
fi