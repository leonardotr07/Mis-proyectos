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
    char*ptr, cadena[9];
    archLectura.getline(cadena, 9, carFinal);
	
	// Si el archivo tiene CRLF, elimina el '\r' final
	/*Al hacer cat -A Pedidos31.csv | head -7
		Salio como resultado:
		2,14268463,BHD6079^M$
		7,42302422,RWW7975^M$
		9,11750801,VDL9379^M$
		11,14268463,XBC5847^M$
		15,60740809,CTW5846^M$
		16,58717040,BZY0235^M$
		26,14268463,VMW6915^M$
		
		Por ende hay que cuidar ese detalle.
	*/
    int len = strlen(cadena);
    if(len > 0 && cadena[len-1] == '\r'){
        cadena[len-1] = '\0';
    }
	
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
