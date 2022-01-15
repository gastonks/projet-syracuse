#!/bin/sh

re='^[0-9]+$'

if [ "${#}" -eq 2 ]
then

    if [ -n "${1}" ] && [ "${1}" -eq "${1}" ] && [ -n "${2}" ] && [ "${2}" -eq "${2}" ] 2>/dev/null;
    then
        if [ "${1}" -gt 0 ] && [ "${2}" -gt 0 ]
        then
            echo "both numbers"
            if [ "${1}" -gt "${2}" ]
            then
                echo "Premier nombre plus grand que le second."
                exit 1
            else
                echo "Good to go"
                echo "${1} ${2}"

                touch data/_altiMax.dat
                touch data/_dureeVol.dat
                touch data/_dureeAlti.dat

                for i in `seq ${1} ${2}`
                do
                    ./bin/syracuse ${i} data/f${i}.dat
                done
  
                gnuplot -e "set terminal jpeg; set output 'img/vols.jpg'; set title 'Un en fonction de n pour tous les U0 dans [${1};${2}]'; set xlabel 'n'; set ylabel 'Un'; plot for [i=${1}:${2}] 'data/f'.i.'.dat' u 1:2 w l t '' lt rgb 'dark-violet'"

                #recupere altiMax
                for FILE in $(ls -t -r data/f*.dat)
                do
                    #recupere les U0
                    grep -Eo "^0 [0-9]*" "${FILE}" | cut -d ' ' -f 2 | tr -d '\n\r' >> data/_altiMax.dat
                    echo " " | tr -d '\n\r' >> data/_altiMax.dat
                    #recupere altiMax
                    grep -Eo 'AltiMax=[0-9]*' "${FILE}" | cut -d '=' -f 2 >> data/_altiMax.dat
                done

                gnuplot -e "set terminal jpeg; set output 'img/altiMax.jpg'; set title 'Altitude maximum atteinte en fonction de U0'; set xlabel 'U0'; set ylabel 'Altitude maximum'; plot 'data/_altiMax.dat' u 1:2 w l t 'altiMax.dat' lt rgb 'dark-violet'"

                #recupere dureeVol
                for FILE in $(ls -t -r data/f*.dat)
                do
                    #recupere les U0
                    grep -Eo "^0 [0-9]*" "${FILE}" | cut -d ' ' -f 2 | tr -d '\n\r' >> data/_dureeVol.dat
                    echo " " | tr -d '\n\r' >> data/_dureeVol.dat
                    #recupere dureeVol
                    grep -Eo 'DureeVol=[0-9]*' "${FILE}" | cut -d '=' -f 2 >> data/_dureeVol.dat
                done

                gnuplot -e "set terminal jpeg; set output 'img/dureeVol.jpg'; set title 'Duree de vol en fonction de U0'; set xlabel 'U0'; set ylabel 'Nombre d occurence'; plot 'data/_dureeVol.dat' u 1:2 w l t 'dureeVol.dat' lt rgb 'dark-violet'"

                #recupere dureeAlti
                for FILE in $(ls -t -r data/f*.dat)
                do
                    #recupere les U0
                    grep -Eo "^0 [0-9]*" "${FILE}" | cut -d ' ' -f 2 | tr -d '\n\r' >> data/_dureeAlti.dat
                    echo " " | tr -d '\n\r' >> data/_dureeAlti.dat
                    #recupere dureeAlti
                    grep -Eo 'DureeAltitude=[0-9]*' "${FILE}" | cut -d '=' -f 2 >> data/_dureeAlti.dat
                done

                gnuplot -e "set terminal jpeg; set output 'img/dureeAlti.jpg'; set title 'Duree de vol en altitude en fonction de U0'; set xlabel 'U0'; set ylabel 'Nombre d occurence'; plot 'data/_dureeAlti.dat' u 1:2 w l t 'dureeAlti.dat' lt rgb 'dark-violet'"

                #rm -r data/*
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