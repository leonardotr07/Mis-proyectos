#include <iostream>
#include <iomanip>
#include <vector>
#include <algorithm>
#include <climits>
using namespace std;
#define NUM_ITERACIONES 10000
#define ALFA 0.15 //Nos dieron el ALFA en el enunciado (Dato)
#define MAX_CAJAS_UTILIZADAS 10
#define CAPACIDAD_CAJA 10 //Como el programa a desarrollar era para un caso. Se coloco este aspecto como constante... Fácilmente pudo ser parametro de entrada.
struct Objeto {
    int id;
    int peso;
};
struct Caja {
    int capacidadMaxima;
    int pesoActual;
    vector<Objeto> objetosEnCaja;
};
int buscarExtremoRCLCaja(int RCL,const vector<Caja> &arrCajas);
void construirSolucion(vector<Objeto>objetos, vector<Caja> &arrCajas,
    vector<Caja>&solucionParcial, int &menorNumCajas);
int buscarExtremoRCL(int RCL, const vector<Objeto>&objetos);
bool comparaCajas(const Caja &cajaA, const Caja &cajaB);
void algoritmoGRASP(vector<Objeto>objetos);

bool comparaObjetos(const Objeto &objetoA, const Objeto &objetoB);
int main() {
    /*
    *Este problema plantea el problema de empaquetado en contenedores (bin packing):
    *se tiene un conjunto de objetos con distintos pesos que deben distribuirse en cajas
    *idénticas con una capacidad máxima fija, buscando minimizar la cantidad de cajas
    *utilizadas y aprovechar al máximo el espacio disponible en cada una.
    *Como ejemplo, con objetos de pesos 4, 8, 1, 4, 2, 1 y cajas de capacidad 10 kg,
    *se muestra una solución válida (aunque no necesariamente óptima) usando 3
    *contenedores.

    Se pidió implementar un algoritmo GRASP de Construcción que reciba como entrada
    la lista de objetos a empacar, y que devuelva el número de contenedores usados
    junto con el detalle de qué objetos fueron asignados a cada uno.

    Se permite reordenar los objetos como parte de la estrategia
    (por ejemplo, ordenándolos por peso) como parte del criterio del algoritmo GRASP.
*/

    //Minimizar la cantidad de cajas necesarias, aprovechando al máximo el espacio disponible.
    vector<Objeto> objetos{
        {1, 4},
        {2, 8},
        {3, 1},
        {4, 4},
        {5, 2},
        {6, 1}
    };
    //Hay que empacar dichos objetos con el menor número cajas posibles...
    algoritmoGRASP(objetos);
    return 0;
}
void algoritmoGRASP(vector<Objeto>objetos) {
    int menorNumCajas=INT_MAX;
    vector<Caja> arrCajas;
    srand(time(NULL));
    vector<Caja>solucionParcial;
    for (int i = 0; i < NUM_ITERACIONES; i++) {
        construirSolucion(objetos, arrCajas, solucionParcial, menorNumCajas);
        solucionParcial.clear();
    }
    //Imprimimos la solución
    cout<<"Se han utilizado "<<menorNumCajas<<" cajas."<<endl;
    for (int i=0; i < arrCajas.size(); i++) {
        cout<<"Contenedor "<<i+1<<": ";
        for (int j=0; j<arrCajas[i].objetosEnCaja.size(); j++) {
            cout<<arrCajas[i].objetosEnCaja[j].peso<<" ";
        }
        cout<<". Peso Utilizado: "<<arrCajas[i].pesoActual<<endl;
    }
}
void construirSolucion(vector<Objeto> objetos, vector<Caja> &solucion,
    vector<Caja> &solucionParcial, int &menorNumCajas) {

    // Limpiar solución parcial
    solucionParcial.clear();

    // Ordenar objetos de mayor a menor
    sort(objetos.begin(), objetos.end(), comparaObjetos);

    while (!objetos.empty()) {
        // Primero seleccionamos el objeto con GRASP
        int betaObj = objetos[0].peso;
        int tauObj = objetos[objetos.size()-1].peso;
        int rclObj = betaObj - ALFA * (betaObj - tauObj);
        int indObj = buscarExtremoRCL(rclObj, objetos);
        int objetoAEscoger = rand() % indObj;

        Objeto objetoSeleccionado = objetos[objetoAEscoger];

        // Después buscamos la mejor caja
        int mejorCaja = -1;
        int menorDesperdicio = INT_MAX;

        for (int i = 0; i < solucionParcial.size(); i++) {
            int espacioRestante = solucionParcial[i].capacidadMaxima -
                                  solucionParcial[i].pesoActual;

            if (espacioRestante >= objetoSeleccionado.peso) {
                int desperdicio = espacioRestante - objetoSeleccionado.peso;
                if (desperdicio < menorDesperdicio) {
                    menorDesperdicio = desperdicio;
                    mejorCaja = i;
                }
            }
        }

        // Si no cabe en ninguna caja, crear nueva
        if (mejorCaja == -1) {
            Caja nuevaCaja;
            nuevaCaja.capacidadMaxima = CAPACIDAD_CAJA;
            nuevaCaja.pesoActual = 0;
            solucionParcial.push_back(nuevaCaja);
            mejorCaja = solucionParcial.size() - 1;
        }

        // Agregar objeto a la caja
        solucionParcial[mejorCaja].objetosEnCaja.push_back(objetoSeleccionado);
        solucionParcial[mejorCaja].pesoActual += objetoSeleccionado.peso;

        // Eliminar objeto de la lista
        objetos.erase(objetos.begin() + objetoAEscoger);
    }

    // Actualizar mejor solución
    if (solucionParcial.size() < menorNumCajas) {
        solucion.clear();
        solucion = solucionParcial;
        menorNumCajas = solucionParcial.size();
    }
}
//Tener cuidado con estos signos... Pueden llegar a colgar el programa
int buscarExtremoRCLCaja(int RCL,const vector<Caja> &arrCajas) {
    int indice=0;
    for (int i=0; i<arrCajas.size(); i++) {
        if (RCL>=arrCajas[i].pesoActual) indice++;
    }
    return indice;
}
int buscarExtremoRCL(int RCL, const vector<Objeto>&objetos) {
    int indice=0;
    for (int i=0; i<objetos.size(); i++) {
        if (RCL<=objetos[i].peso) {
            indice++;
        }else break;
    }
    return indice;
}
//De Mayor a Menor.
bool comparaObjetos(const Objeto &objetoA, const Objeto &objetoB) {
    return objetoA.peso > objetoB.peso;
}
//De Menor a Mayor.
bool comparaCajas(const Caja &cajaA, const Caja &cajaB) {
    return cajaA.pesoActual < cajaB.pesoActual;
}