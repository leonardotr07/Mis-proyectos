
#include <cstdlib>
#include <iostream>
#include <cmath>
#include <fstream>

using namespace std;

#include "Elemento.h"
#include "Pila.h"
#include "funcionesPila.h"
#define MAX 10
void movimientosNautilus(char movimientos[MAX], int cantMovimientos);
int main(int argc, char** argv) {
	/*

	El algoritmo es para un robot submarino llamado "Nautilus" que se desplaza 
	entre distintos niveles de profundidad siguiendo una trayectoria programada 
	mediante comandos de subida (`S`) o bajada (`B`). Debido a que las cargas de 
	profundidad enemigas explotan a niveles ya detectados, el robot nunca puede 
	volver a pasar por un nivel en el que ya estuvo, ya sea subiendo o bajando; 
	cada movimiento debe llevarlo a un nivel numérico nuevo (los niveles se 
	numeran con enteros positivos consecutivos empezando en 1, según la cantidad 
	de órdenes recibidas).

	El objetivo es, dada una secuencia de órdenes `S`/`B` (almacenada en un 
	arreglo), generar la secuencia de niveles por los que pasa el Nautilus, 
	de modo que se respete el patrón de subidas y bajadas indicado sin repetir 
	ningún nivel. La restricción de implementación es fuerte: el algoritmo debe 
	resolverse usando **una única pila** como estructura auxiliar, sin recurrir 
	a ningún otro TAD ni arreglo adicional (el arreglo de entrada solo puede 
	usarse para leer las órdenes, no para almacenar resultados intermedios).
*/
	
	
    ifstream archLectura("datos.txt", ios::in);
    if(not archLectura.is_open()){
        cout<<"No se pudo abrir datos.txt";
        exit(1);
    }
    char movimientos[MAX];
    int cantMovimientos;
    archLectura>>cantMovimientos;
    for (int i = 0; i < cantMovimientos; i++) {
        archLectura>>movimientos[i];
    }
    //Ya hemos leido...
    movimientosNautilus(movimientos, cantMovimientos);
    return 0;
}
void movimientosNautilus(char movimientos[MAX], int cantMovimientos){
    Pila pila;
    construir(pila);
    int i=1, j=0; //i es el numero de niveles y j es el indice del arreglo de movimientos
    bool existeBajada=false;
    while(i<=cantMovimientos+1){
        if(i==cantMovimientos+1 or movimientos[j]=='S'){
            apilar(pila, i);
            if(existeBajada){
                //Vaciamos toda la pila.
                while(!esPilaVacia(pila)){
                    int numero=desapilar(pila);
                    cout<<numero<<' ';
                }
                existeBajada=false;
            }else{
                int nivel=desapilar(pila);
                cout<<nivel<<' ';
            }
        } else{ //Si es 'B'
            apilar(pila, i);
            existeBajada=true;
        }
        i++;
        j++;
    }
    while(!esPilaVacia(pila)){
        int numero=desapilar(pila);
        cout<<numero<<' ';
    }
}
