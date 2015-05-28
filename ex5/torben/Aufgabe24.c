#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main (){
	
	time_t seed;
	int i = 0, j, bFits, a, b, f, res;
    
	time (&seed);
	srand((unsigned int) seed);
	
    //erzeuge eine Liste von 20 paarw. disj. Aufgabentupeln (a,b,f)
    int arr[60];
    while (i<60){
        a = rand() % 100;
        f = rand() % 2;
        
        //versuche maximal 5 Mal, ein passendes b zu a und f zu finden
        res = 0;
        bFits = 0;
        while(!bFits && res++ < 5){
            bFits = 1;
            if(f == 0)
                b = rand() % (100 - a);
            else
                b = rand() % a;
            for (j = 0; j<60; j+=3){
                if(arr[j] == a && arr[j+1] == b && arr[j+2] == f)
                    bFits = 0;
            }
        }
        //falls passendes b gefunden, merke Tupel (a,b,f)
        if(bFits){
            arr[i]   = a;
            arr[i+1] = b;
            arr[i+2] = f;
            i += 3;
        }
    }
    
    //interaktive Loesungseingabe mit den erzeugten Aufgabentupeln
	for(i = 0; i<60; i+=3){
		a = arr[i];
        b = arr[i+1];
		f = arr[i+2];
		if (f == 0){
			printf("%d + %d = ", a, b);
            scanf("%d", &res);
            if(res == a + b)
                printf("Richtig!\n\n");
            else
                printf("Falsch!\n\n");
		}
		else{
			printf("%d - %d = ", a, b);
            scanf("%d", &res);
            if(res == a - b)
                printf("Richtig!\n\n");
            else
                printf("Falsch!\n\n");
		}
	}
	return 0;
}
