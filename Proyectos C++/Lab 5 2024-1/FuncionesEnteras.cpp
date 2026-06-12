/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

#include <iomanip>
#include <fstream>
#include <iostream>

using namespace std;

void* leenum(ifstream &archLectura){
    void*registro;
    int*numero, num;
    archLectura>>num;
    if(archLectura.eof()) return nullptr;
    numero=new int;
    *numero=num;
    registro=numero;
    return registro;
}
void imprimenum(void*dato, ofstream &archReporte){
    //Solo es un numero
    int*numero=(int*)dato;
    archReporte<<*numero<<endl;
}
int cmpnum(void*dato1, void*dato2){
    int*numero1=(int*)dato1;
    int*numero2=(int*)dato2;
    return *numero2-*numero1;
//    return *numero1-*numero2;
}