
#include <cstdlib>
#include <iostream>
#include <cmath>

using namespace std;

#include "FuncionesRegistros.h"
#include "BibliotecaGenerica.h"
#include "FuncionesEnteras.h"
int main(int argc, char** argv) {
    //Leonardo Tueros
    /*La idea de este ejercicio era crear una lista generica simplemente ligada
    * En donde sus funciones estan en BibliotecaGenerica. Y debe funcionar tanto para elementos
    * como numeros o estructuras mayores (registros)
     */
    void*pedidos1, *pedidos2, *pedidosFinal;
    crealista(pedidos1, leenum, "RegistroNum1.txt");
    imprimirlista(pedidos1, imprimenum, "Repnum1.txt");
    crealista(pedidos2, leenum, "RegistroNum2.txt");
    imprimirlista(pedidos2, imprimenum, "Repnum2.txt");
    combinarLista(pedidos1, pedidos2, pedidosFinal, cmpnum);
    imprimirlista(pedidosFinal, imprimenum, "RepnumFinal.txt");
    
    crealista(pedidos1, leeregistro, "Pedidos31.csv");
    imprimirlista(pedidos1, imprimeregistro, "Repreg1.txt");
    crealista(pedidos2, leeregistro, "Pedidos32.csv");
    imprimirlista(pedidos2, imprimeregistro, "Repreg2.txt");
    combinarLista(pedidos1, pedidos2, pedidosFinal, cmpregistro);
    imprimirlista(pedidosFinal, imprimeregistro, "RepregFinal.txt");
    

    return 0;
}

