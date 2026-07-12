#include <iostream>
#include <iomanip>
using namespace std;
#define N 5
#define INICIALIZAR_MIN_COSTO 999999
void recorrerLaberintoConMenorCosto(int laberinto[N][N], int posiblesMovimientos[4][2],
    int posX, int posY, int costo, int &costoMin, int solucion[N][N]);
bool validarMovimiento(int newX, int newY, int laberinto[N][N]);
int main() {
    /*Este problema plantea encontrar el camino de menor costo en un laberinto de NxN celdas usando la
     *técnica de backtracking. Cada celda tiene un costo de tránsito (0 = impasable, 1 = tierra firme,
     *2 = tierra arenosa, 3 = lodo), y el robot parte de la celda (0,0) con el objetivo de llegar a la
     *celda (N-1, N-1), pudiendo moverse en las 4 direcciones (arriba, abajo, izquierda, derecha) en
     *cada paso, sin salirse del laberinto ni pisar celdas con costo 0.
     *
     *El algoritmo debe explorar recursivamente todos los caminos posibles (marcando con -1 y desmarcando
     *celdas visitadas, como es típico en backtracking) para encontrar aquel cuya suma de costos de
     *las celdas recorridas sea mínima, mostrando finalmente el costo mínimo total y el camino resultante
     *marcado sobre la matriz del laberinto.*/
    int solucion[N][N];
    int laberinto[N][N] {
        {1, 2, 0, 1, 0},
        {3, 2, 3, 1, 1},
        {0, 1, 2, 0, 0},
        {3, 1, 1, 2, 3},
        {0, 1, 3, 1, 1}
    };
    int posiblesMovimientos[4][2] {
        {0, 1},
        {0, -1},
        {1, 0},
        {-1, 0}
    };
    int costo=laberinto[0][0];
    laberinto[0][0]=-1; //Lo marco ya que estoy en la posicion inicial
    int costoMin=INICIALIZAR_MIN_COSTO;
    recorrerLaberintoConMenorCosto(laberinto, posiblesMovimientos, 0, 0, costo, costoMin, solucion);

    cout<<"Costo Minimo Encontrado: "<<costoMin<<endl;
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            cout << setfill('0') << setw(2) << solucion[i][j] << " ";
        }
        cout << endl;
    }
    return 0;
}
void recorrerLaberintoConMenorCosto(int laberinto[N][N], int posiblesMovimientos[4][2],
    int posX, int posY, int costo, int &costoMin, int solucion[N][N]) {
    if (posX==N-1 and posY==N-1) {
        if (costoMin>costo) {
            costoMin=costo; //Asignamos el nuevo costoMinimo...
            //Copiamos la solucion del laberinto a la solucion...
            for (int i=0;i<N;i++) {
                for (int j=0;j<N;j++) {
                    solucion[i][j]=laberinto[i][j];
                }
            }
        }
        return; //Terminó el recorrido.
    }

    //Recorremos cada movimiento Posible...
    int newX, newY, costoPosicion;
    for (int i = 0; i < 4; i++) {
        newX=posX+posiblesMovimientos[i][0];
        newY=posY+posiblesMovimientos[i][1];
        //Colocaré el valor de -1 como la casilla que paso ya el robot
        if (validarMovimiento(newX, newY, laberinto)) {
            costo+=laberinto[newX][newY];
            costoPosicion=laberinto[newX][newY];
            laberinto[newX][newY]=-1;
            //Llamamos a la funcion...
            recorrerLaberintoConMenorCosto(laberinto, posiblesMovimientos, newX,
                newY, costo, costoMin, solucion);
            //Lo volvemos a como estaba antes y sigo evaluando otra opción
            costo-=costoPosicion;
            laberinto[newX][newY]=costoPosicion;
        }
    }
}
//Esta funcion SOLO VALIDA si el Movimiento es valido (Si no se sale del tablero o que el camino es impasable)
bool validarMovimiento(int newX, int newY, int laberinto[N][N]) {
    //Si esta dentro del laberinto, el camino es posible y si no ha pasado por ahi
    if (newX>=0 and newX<N and newY>=0 and newY<N and laberinto[newX][newY]!=0 and laberinto[newX][newY]!=-1) return true;
    return false;
}