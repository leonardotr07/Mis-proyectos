/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

#include <iomanip>
#include <fstream>
#include <iostream>
#include <cstring>

using namespace std;

#include "FuncionesRegistros.h"
void* leeregistro(ifstream &archLectura){
    void**registro;
    int*numPed, *DNI, numPedido, dni;
    char*codLibro, car;
    archLectura>>numPedido;
    if(archLectura.eof()) return nullptr;
    archLectura>>car>>dni>>car;
    codLibro=leerCadenaExacta(archLectura, '\n');
    numPed=new int, DNI=new int;
    *numPed=numPedido, *DNI=dni;
    registro=new void*[3];
    registro[0]=numPed;
    registro[1]=DNI;
    registro[2]=codLibro;
    return registro;
}
char*leerCadenaExacta(ifstream &archLectura, char carFinal){
    char*ptr, cadena[8];
    archLectura.getline(cadena, 8, carFinal);
    ptr=new char[strlen(cadena)+1];
    strcpy(ptr, cadena);
    return ptr;
}
void imprimeregistro(void*dato, ofstream &archReporte){
    void**datos=(void**)dato;
    int*numPedido=(int*)datos[0];
    int*DNI=(int*)datos[1];
    char*codLibro=(char*)datos[2];
    archReporte<<*numPedido<<' '<<*DNI<<' '<<codLibro<<endl;
}
int cmpregistro(void*dato1, void*dato2){
    void**datosNodo1=(void**)dato1;
    void**datosNodo2=(void**)dato2;
    int*numPed1=(int*)datosNodo1[0];
    int*numPed2=(int*)datosNodo2[0];
    return *numPed2-*numPed1;
}