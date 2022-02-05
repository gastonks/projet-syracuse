#include "header.h"

// Returning the largest number.
int getAltiMax(int alti, int altiMax){
	return (alti >= altiMax) ? alti : altiMax;
}

// Returning the largest number.
int max (int a, int b) {
	return (a >= b) ? a : b;
}

int main(int argc, char *argv[]){


	if(argv[1] == NULL){
		// Printing a message if the first argument is NULL.
		printf("ERROR IN C FILE: It is necessary to have 2 arguments in the input.\nThe first argument must be an integer strictly positve and the second one a path to a file for its creation.\nExample: ./syracuse [NUMBER] [FILE-OUT]\n");
		//printf("ERROR IN C FILE: Please enter exactly 2 argumets, where one is a positive number.\nExample: ./syracuse [NUMBER] [FILE-OUT]\n");
		exit(-1);
	}else{
		if(argc != 3 || atoi(argv[1]) <= 0 ){
			// Printing a message if there are no three arguments or if the first argument is less than or equal to zero.
			printf("ERROR IN C FILE: It is necessary to have 2 arguments in the input.\nThe first argument must be an integer strictly positve and the second a path to a file for its creation.\nExample: ./syracuse [NUMBER] [FILE-OUT]\n");
			//printf("ERROR IN C FILE: Please enter exactly 2 argumets, where one is a positive number.\nExample: ./syracuse [NUMBER] [FILE-OUT]\n");
			exit(-2);
		}else{

			// Converting the argument to an integer. If there is a float, it is rounded down.
			int un = atoi(argv[1]);
			
			// Creating a file and checking if it has been created.
			FILE* file = fopen(argv[2], "w");
			if(file == NULL){
				printf("ERROR IN C FILE: Output file not created.");
				exit(-1);
			}

			
			int altiMax = un;
			int durationFlight = 0;
			int counter = 0;

			int durationAltitude = 0;
			int tmpDurationAltitude = 0;
			int durationAltitudeMax = 0;

			int nextAltitude = 0;
			int previousAltitude = un;

			// Writing in the file the n (=0) and the Un (=the first argument).

			//printf("n Un");
			fprintf(file, "n Un");
			//printf("\n%i %i", counter, previousAltitude);
			fprintf(file, "\n%i %i", counter, previousAltitude);
				
			// Looping until we reach 1.
			while (previousAltitude != 1){

				// Checking whether it is a multiple of two or not.
				if(previousAltitude % 2 == 0){
					nextAltitude = previousAltitude/2;
				}else{
					nextAltitude = previousAltitude*3+1;
				}

				// Getting the maximum altitude and increasing the duration flight.
				altiMax = getAltiMax(nextAltitude, altiMax);
				durationFlight++;

				// Getting the duration flight in altitude.
				if(nextAltitude > un) {
					durationAltitude++;
					tmpDurationAltitude = durationAltitude;
				}else{
					durationAltitudeMax = max(durationAltitudeMax, tmpDurationAltitude);
					durationAltitude = 0;
				}
					
				previousAltitude = nextAltitude;
				counter++;
					
				/*	Displaying in the terminal the 'n' and the value of 'Un'	*/
				//printf("\n%i %i", counter, previousAltitude);

				/*	Writing the 'n' and the value of 'Un' into the file	*/
				fprintf(file, "\n%i %i", counter, previousAltitude);

			}

			/*	Displaying in the terminal of maximum altitude, flight duration and altitude flight duration	*/
			//printf("\nAltiMax=%i", altiMax);
			//printf("\ndurationFlight=%i",durationFlight);
			//printf("\ndurationAltitude=%i\n", durationAltitudeMax);

			/*	Writing the maximum altitude, flight duration and altitude flight duration to the file	*/
			fprintf(file, "\nAltiMax=%i", altiMax);
			fprintf(file, "\ndurationFlight=%i",durationFlight);
			fprintf(file, "\ndurationAltitude=%i", durationAltitudeMax);


			// Closing the file
			fclose(file);
		}
	}

	return 0;
}
