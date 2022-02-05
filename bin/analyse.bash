#!/bin/sh

function helpMessage(){
    echo "\nIt is necessary to have 2 arguments in the input.\nBoth arguments must be integers strictly positve.\nThe first integer must be greater than the second integer.\nUsage:\n\t./bin/analyse.bash 100 500\n\t./bin/analyse.bash -h (printing this message)."
}

if ! [ $(find "./bin/syracuse") ]
then
    echo "\nExecutable not available. Need to compile. To compile use 'make'."
    echo "Creating the executable using 'make'."
    make
fi

if [ "${#}" -eq 1 ]
then
    if [ "${1}" == "-h" ]
    then
        helpMessage
        exit 0
    fi
fi

if [ "${#}" -eq 2 ]
then
    if [ -n "${1}" ] && [ "${1}" -eq "${1}" ] && [ -n "${2}" ] && [ "${2}" -eq "${2}" ]
    then
        if [ "${1}" -gt 0 ] && [ "${2}" -gt 0 ]
        then
            
            if [ "${1}" -gt "${2}" ]
            then
                helpMessage
                exit 1
            else

                if ! [ -d "img/" ]
                then
                    mkdir img
                fi

                if ! [ -d "data/" ]
                then
                    mkdir data
                fi

                touch data/_altiMax_${1}_${2}.txt
                touch data/_dureeVol_${1}_${2}.txt
                touch data/_dureeAlti_${1}_${2}.txt

                if [ "${1}" -eq "${2}" ]
                then
                    echo "Creating the data files..."
                    for i in `seq ${1} ${2}`
                    do
                        ./bin/syracuse ${i} data/f${i}.dat
                    done
                    echo "Data files created."
        
                    echo "Creating 'img/vols.jpg'."
                    gnuplot -e "set terminal jpeg size 1600, 900; set output 'img/vols_${1}_${2}.jpg'; set title 'Un en fonction de n pour tous les U0 dans [${1};${2}]'; set xlabel 'n'; set ylabel 'Un'; plot for [i=${1}:${2}] 'data/f'.i.'.dat' u 1:2 w l t '' lt rgb 'dark-violet'" 2> /dev/null;
                    echo "'img/vols.jpg' created."

                    echo "Creating 'img/altiMax.jpg'..."
                    #recover altiMax
                    for FILE in $(ls -t -r data/f*.dat)
                    do
                        #recover the U0s
                        grep -Eo "^0 [0-9]*" "${FILE}" | cut -d ' ' -f 2 | tr -d '\n\r' >> data/_altiMax_${1}_${2}.txt
                        echo " " | tr -d '\n\r' >> data/_altiMax_${1}_${2}.txt
                        #recover altiMax
                        grep -Eo 'AltiMax=[0-9]*' "${FILE}" | cut -d '=' -f 2 >> data/_altiMax_${1}_${2}.txt
                    done

                    gnuplot -e "set terminal jpeg size 1600, 900; set output 'img/altiMax_${1}_${2}.jpg'; set title 'Altitude maximum atteinte en fonction de U0'; set xlabel 'U0'; set ylabel 'Altitude maximum'; plot 'data/_altiMax_${1}_${2}.txt' u 1:2 w p t 'altiMax.dat' lt rgb 'dark-violet'" 2> /dev/null;
                    echo "'img/altiMax.jpg' created."

                    echo "Creating 'img/durationFlight.jpg'..."
                    #recover durationFlight
                    for FILE in $(ls -t -r data/f*.dat)
                    do
                        #recover the U0s
                        grep -Eo "^0 [0-9]*" "${FILE}" | cut -d ' ' -f 2 | tr -d '\n\r' >> data/_dureeVol_${1}_${2}.txt
                        echo " " | tr -d '\n\r' >> data/_dureeVol_${1}_${2}.txt
                        #recupere durationFlight
                        grep -Eo 'durationFlight=[0-9]*' "${FILE}" | cut -d '=' -f 2 >> data/_dureeVol_${1}_${2}.txt
                    done

                    gnuplot -e "set terminal jpeg size 1600, 900; set output 'img/durationFlight_${1}_${2}.jpg'; set title 'Duree de vol en fonction de U0'; set xlabel 'U0'; set ylabel 'Nombre d occurence'; plot 'data/_dureeVol_${1}_${2}.txt' u 1:2 w p t 'durationVol.dat' lt rgb 'dark-violet'" 2> /dev/null;
                    echo "'img/durationFlight.jpg' created."

                    echo "Creating 'img/durationAlti.jpg'..."
                    #recover durationAltitude
                    for FILE in $(ls -t -r data/f*.dat)
                    do
                        #recover the U0s
                        grep -Eo "^0 [0-9]*" "${FILE}" | cut -d ' ' -f 2 | tr -d '\n\r' >> data/_dureeAlti_${1}_${2}.txt
                        echo " " | tr -d '\n\r' >> data/_dureeAlti_${1}_${2}.txt
                        #recover durationAltitude
                        grep -Eo 'durationAltitude=[0-9]*' "${FILE}" | cut -d '=' -f 2 >> data/_dureeAlti_${1}_${2}.txt
                    done

                    gnuplot -e "set terminal jpeg size 1600, 900; set output 'img/durationAlti_${1}_${2}.jpg'; set title 'Duree de vol en altitude en fonction de U0'; set xlabel 'U0'; set ylabel 'Nombre d occurence'; plot 'data/_dureeAlti_${1}_${2}.txt' u 1:2 w p t 'durationAlti.dat' lt rgb 'dark-violet'" 2> /dev/null;
                    echo "'img/durationAlti.jpg' created."

                    echo "Deleting temporary data..."
                    rm -r data/*.dat
                    rm data
                    echo "Deletion of temporary data completed."
                    exit 0
                fi


                echo "Creating the data files..."
                for i in `seq ${1} ${2}`
                do
                    ./bin/syracuse ${i} data/f${i}.dat
                done
                echo "Data files created."
    
                echo "Creating 'img/vols.jpg'."
                gnuplot -e "set terminal jpeg size 1600, 900; set output 'img/vols_${1}_${2}.jpg'; set title 'Un en fonction de n pour tous les U0 dans [${1};${2}]'; set xlabel 'n'; set ylabel 'Un'; plot for [i=${1}:${2}] 'data/f'.i.'.dat' u 1:2 w l t '' lt rgb 'dark-violet'"
                echo "'img/vols.jpg' created."

                echo "Creating 'img/altiMax.jpg'..."
                #recover altiMax
                for FILE in $(ls -t -r data/f*.dat)
                do
                    #recover the U0s
                    grep -Eo "^0 [0-9]*" "${FILE}" | cut -d ' ' -f 2 | tr -d '\n\r' >> data/_altiMax_${1}_${2}.txt
                    echo " " | tr -d '\n\r' >> data/_altiMax_${1}_${2}.txt
                    #recover altiMax
                    grep -Eo 'AltiMax=[0-9]*' "${FILE}" | cut -d '=' -f 2 >> data/_altiMax_${1}_${2}.txt
                done

                gnuplot -e "set terminal jpeg size 1600, 900; set output 'img/altiMax_${1}_${2}.jpg'; set title 'Altitude maximum atteinte en fonction de U0'; set xlabel 'U0'; set ylabel 'Altitude maximum'; plot 'data/_altiMax_${1}_${2}.txt' u 1:2 w l t 'altiMax.dat' lt rgb 'dark-violet'"
                echo "'img/altiMax.jpg' created."

                echo "Creating 'img/durationFlight.jpg'..."
                #recover durationFlight
                for FILE in $(ls -t -r data/f*.dat)
                do
                    #recover the U0s
                    grep -Eo "^0 [0-9]*" "${FILE}" | cut -d ' ' -f 2 | tr -d '\n\r' >> data/_dureeVol_${1}_${2}.txt
                    echo " " | tr -d '\n\r' >> data/_dureeVol_${1}_${2}.txt
                    #recupere durationFlight
                    grep -Eo 'durationFlight=[0-9]*' "${FILE}" | cut -d '=' -f 2 >> data/_dureeVol_${1}_${2}.txt
                done

                gnuplot -e "set terminal jpeg size 1600, 900; set output 'img/durationFlight_${1}_${2}.jpg'; set title 'Duree de vol en fonction de U0'; set xlabel 'U0'; set ylabel 'Nombre d occurence'; plot 'data/_dureeVol_${1}_${2}.txt' u 1:2 w l t 'durationVol.dat' lt rgb 'dark-violet'"
                echo "'img/durationFlight.jpg' created."

                echo "Creating 'img/durationAlti.jpg'..."
                #recover durationAltitude
                for FILE in $(ls -t -r data/f*.dat)
                do
                    #recover the U0s
                    grep -Eo "^0 [0-9]*" "${FILE}" | cut -d ' ' -f 2 | tr -d '\n\r' >> data/_dureeAlti_${1}_${2}.txt
                    echo " " | tr -d '\n\r' >> data/_dureeAlti_${1}_${2}.txt
                    #recover durationAltitude
                    grep -Eo 'durationAltitude=[0-9]*' "${FILE}" | cut -d '=' -f 2 >> data/_dureeAlti_${1}_${2}.txt
                done

                gnuplot -e "set terminal jpeg size 1600, 900; set output 'img/durationAlti_${1}_${2}.jpg'; set title 'Duree de vol en altitude en fonction de U0'; set xlabel 'U0'; set ylabel 'Nombre d occurence'; plot 'data/_dureeAlti_${1}_${2}.txt' u 1:2 w l t 'durationAlti.dat' lt rgb 'dark-violet'"
                echo "'img/durationAlti.jpg' created."

                echo "Deleting temporary data..."
                rm -r data/*.dat
                rm data
                echo "Deletion of temporary data completed."
                exit 0
            fi
        else
            helpMessage
            exit 1
        fi
    else
        helpMessage
        exit 3
    fi
else
    helpMessage
    exit 2
fi