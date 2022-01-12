#include "header.h"

int getAltiMax(int alti, int altiMax){
	return (alti >= altiMax) ? alti : altiMax;
}


int max (int a, int b) {
	return (a >= b) ? a : b;
}

int main(int argc, char *argv[]){


	//printf("argc=%i", argc);

	//printf("\n%s; %s\n", argv[1], argv[2]);


	int un = atoi(argv[1]);

	if((argc < 3 || argc > 3)){
		printf("Veuillez entrer au moins 2 arguments.\nExemple: ./syracuse [NOMBRE] [FICHIER-SORTIE]\n");
		exit(-1);
	}else{
		if(un <= 0){
			printf("Veuillez entrer au moins 2 arguments et un nombre strictement positif.\nExemple: ./syracuse [NOMBRE] [FICHIER-SORTIE]\n");
			exit(-1);
		}else{

			//printf("\n%s; %s\n", argv[1], argv[2]);

		
			FILE* file = fopen(argv[2], "w");
			if(file == NULL){
				printf("Fichier de sortie non cree.");
				exit(-1);
			}

		
			int altiMax = un;
			int dureeVol = 0;
			int compteur = 0;

			int dureeAltitude = 0;
			int tmpDureeAltitude = 0;
			int dureeAltitudeMax = 0;

			int altitudeSuivant = 0;
			int altitudePrecedent = un;

			printf("n Un");
			fprintf(file, "n Un");
			printf("\n%i %i", compteur, altitudePrecedent);
			fprintf(file, "\n%i %i", compteur, altitudePrecedent);
			
			do{

				if(altitudePrecedent % 2 == 0){
					altitudeSuivant = altitudePrecedent/2;
				}else{
					altitudeSuivant = altitudePrecedent*3+1;
				}
				altiMax = getAltiMax(altitudeSuivant, altiMax);
				dureeVol++;


				if(altitudeSuivant > un) {
					dureeAltitude++;
					tmpDureeAltitude = dureeAltitude;
				}else{
					dureeAltitudeMax = max(dureeAltitudeMax, tmpDureeAltitude);
					dureeAltitude = 0;
				}
				

				altitudePrecedent = altitudeSuivant;
				compteur++;
				
				/*	Affichage dans le terminal du 'n' et de la valeur de Un	*/
				printf("\n%i %i", compteur, altitudePrecedent);

				/*	Ecriture dans le fichier du 'n' et de la valeur de Un	*/
				fprintf(file, "\n%i %i", compteur, altitudePrecedent);

			} while (altitudePrecedent != 1);

			/*	Affichage dans le terminal de l'altitude maximal, de la duree de vol et de la duree de vol en altitude	*/
			printf("\nAltiMax=%i", altiMax);
			printf("\nDureeVol=%i",dureeVol);
			printf("\nDureeAltitude=%i\n", dureeAltitudeMax);

			/*	Ecriture dans le fichier de l'altitude maximal, de la duree de vol et de la duree de vol en altitude	*/
			fprintf(file, "\nAltiMax=%i", altiMax);
			fprintf(file, "\nDureeVol=%i",dureeVol);
			fprintf(file, "\nDureeAltitude=%i\n", dureeAltitudeMax);

			fclose(file);
		}
	}

	return 0;
}
