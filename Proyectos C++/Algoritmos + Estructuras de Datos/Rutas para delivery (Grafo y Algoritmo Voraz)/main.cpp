#include <iostream>
#include <iomanip>
using namespace std;
#define MAX_PUNTOS 8
int hallarMenorTiempoVoraz(int caminos[][MAX_PUNTOS], char zonaInicio, char zonaFin, char*zonas);
int main() {
    /*Un grafo! Algoritmos Voraces
    *Este problema, del curso de Algoritmos Avanzados, pide implementar un algoritmo heurístico
    *voraz (greedy) para el sistema de delivery, que debe encontrar rápidamente
    *una ruta entre un punto de partida y un punto de llegada dentro de un grafo de ubicaciones
    *(representado en un diagrama con nodos A-H y tiempos de viaje entre ellos).
    *
    *El algoritmo recibe como entrada el grafo de rutas, el punto de partida y el punto de
    *llegada, y debe reportar el tiempo total de viaje. La clave del ejercicio es que, al
    *ser una heurística voraz, el algoritmo debe seguir el principio de miopía: en cada paso
    *elige localmente la mejor opción disponible (por ejemplo, la ruta más corta desde el
    *nodo actual) sin reconsiderar decisiones pasadas ni garantizar la solución óptima global.
    *
    *Casos de Prueba:
    * - (A->G en 16 min),
    * - (C->G: "No se encontró una solución")
    * - (D->G: en 5 min)
     */
    //Insertar las letras como parametros!
    //Las columnas son asi: Caminos para llegar a A, B, C, D, E, F, G, H
    //Filas son asi: Punto en donde me encuentro: A, B, C, D, E, F, G, H
    //Matriz de adyacencia del grafo:


    int caminos[][MAX_PUNTOS] {
        {0, 4, 5, 6, 0, 0, 0, 0}, //A
        {0, 0, 0, 0, 2, 0, 0, 0}, //B
        {0, 0, 0, 0, 0, 0, 0, 3}, //C
        {0, 0, 0, 0, 0, 3, 0, 0}, //D
        {0, 0, 0, 0, 0, 0, 10, 0},//E
        {0, 0, 0, 0, 0, 0, 2, 0}, //F
        {0, 0, 0, 0, 0, 0, 0, 0}, //G
        {0, 0, 0, 0, 0, 0, 0, 0}  //H
    };
    char puntoInicio, puntoFinal;
    //Criterio Voraz... El menor tiempo posible...
    cout<<"Ingrese el punto de partida: ";
    cin>>puntoInicio;
    cout<<"Ingrese el punto de llegada: ";
    cin>>puntoFinal;
    char zonas[MAX_PUNTOS]{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'};
    int resultadoMenorTiempo=hallarMenorTiempoVoraz(caminos, puntoInicio, puntoFinal, zonas);
    if (resultadoMenorTiempo!=-1)
        cout<<"Tiempo de viaje (Vorazmente): "<<resultadoMenorTiempo<<" min"<<endl;
    else
        cout<<"No se encontro solucion."<<endl;
    return 0;
}
int hallarMenorTiempoVoraz(int caminos[][MAX_PUNTOS], char zonaInicio, char zonaFin, char*zonas) {
    //Primero encontramos los puntosInicio y puntoFinal
    int puntoInicio=-1, puntoFinal=-1;
    for(int i = 0; i < MAX_PUNTOS; i++) {
        if (zonas[i] == zonaInicio) puntoInicio = i;
        if (zonas[i]==zonaFin) puntoFinal = i;
    }
    if (zonaFin==zonaInicio) return 0;

    //Ahora sí... El algoritmo
    int caminoMenor;
    int sumaTiempo=0;
    int posicionIntermedia; //Punto llegada intermedio... Por ejemplo para llegar desde A hasta G tengo q pasar por D
    int i=puntoInicio;
    while (i!=puntoFinal) {
        //Empiezo a evaluar los caminos que tengo disponibles
        caminoMenor=999999;

        for (int j=0; j < MAX_PUNTOS; j++) {
            if (caminos[i][j]>0 and caminos[i][j]<caminoMenor) {
                caminoMenor=caminos[i][j];
                posicionIntermedia=j;
            }
        }
        if (caminoMenor==999999) return -1; //No encontró camino...
        sumaTiempo+=caminoMenor;
        i=posicionIntermedia;
    }
    //Si llega aqui es xq llegó al puntoFinal (Punto de llegada)
    return sumaTiempo;
}