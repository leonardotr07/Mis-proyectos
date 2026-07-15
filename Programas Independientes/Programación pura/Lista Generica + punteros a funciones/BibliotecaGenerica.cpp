/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

#include <iomanip>
#include <fstream>
#include <iostream>

using namespace std;

#include "FuncionesRegistros.h"
#include "BibliotecaGenerica.h"
void crealista(void*&pedidos, void*(*leenum)(ifstream &), const char*nombArchCsv){
    ifstream archLectura(nombArchCsv, ios::in);
    if(not archLectura.is_open()){
        cout<<"No se pudo abrir "<<nombArchCsv;
        exit(1);
    }
    pedidos=new void*[2]{};
    void**lista=(void**)pedidos;
    void*reg;
    while(true){
        reg=leenum(archLectura);
        if(archLectura.eof()) break;
        //No le pasamos ninguna funcion compare ya que todo esta insertado de manera ordenada
        insertarlista(reg, pedidos);
        lista[1]=reg;
    }
}
void insertarlista(void*dato, void*&pedidos){
    //La idea de este algoritmo es que inserteAlFinal
    void**lista=(void**)pedidos;
    //Creamos un nodo para el dato
    void**nuevoDato=new void*[2]{};
    nuevoDato[0]=dato; //Es el nodo nuevo al que vamos a insertar.
    void**ultimo=nullptr; //Hallamos el ultimo dato.
    void**recorrido=(void**)lista[0]; //Apunta al inicio;
    while(recorrido){
        ultimo=recorrido;
        recorrido=(void**)recorrido[1];
    }
    if(ultimo==nullptr){
        lista[0]=nuevoDato;
        lista[1]=nuevoDato;
    }else{
        ultimo[1]=nuevoDato;
        lista[1]=nuevoDato;
    }
}
void imprimirlista(void* pedidos, void(*imprimenum)(void*, ofstream &), const char*nombArchTxt){
    ofstream archReporte(nombArchTxt, ios::out);
    if(not archReporte.is_open()){
        cout<<"No se pudo abrir "<<nombArchTxt;
        exit(1);
    }
    void**lista=(void**)pedidos;
    //Le pasamos el inicio de la lista.
    void**recorrido=(void**)lista[0];
    while(recorrido){
        imprimenum(recorrido[0], archReporte);
        recorrido=(void**)recorrido[1];
    }
}
void combinarLista(void*&pedidos1, void*&pedidos2,
        void*&pedidosFinal, int(*cmpnum)(void*, void*)){
    //Primero Declaramos el espacion de pedidosFinal
    pedidosFinal=new void*[2]{};
    void**listaCombinada=(void**)pedidosFinal;
    //Elimina nodo actua cuando 2 numeros son iguales.
    //Algoritmo de Fusion.
    void**lista1=(void**)pedidos1;
    void**lista2=(void**)pedidos2;
    void**recorrido1=(void**)lista1[0];
    void**recorrido2=(void**)lista2[0];
    void**nodoAColocar; //Colocaremos en este puntero el nodo a colocar en la lista.
    while(recorrido1!=nullptr and recorrido2!=nullptr){
        if(cmpnum(recorrido1[0], recorrido2[0])>=0){
            //Hay q cambiar insertarLista por otro algoritmo
            //En insertarLista hay crearNodo y esa no es la idea.
            //Colocamos el nodo1
            nodoAColocar=recorrido1;
            recorrido1=(void**)recorrido1[1]; //Recorrido pasa al siguiente
            nodoAColocar[1]=nullptr; //Desvinculamos el nodo a colocar de la lista.
            colocarEnListaCombinada(nodoAColocar, pedidosFinal); //Lo colocamos en la lista.
        }else{
            nodoAColocar=recorrido2;
            recorrido2=(void**)recorrido2[1];
            nodoAColocar[1]=nullptr;
            colocarEnListaCombinada(nodoAColocar, pedidosFinal);
        }
    }
    //Preguntamos cual de las listas termino.
    if(recorrido1==nullptr){
        listaCombinada[1]=lista2[1];
    } else{
        listaCombinada[1]=lista1[1];
    }
}
void colocarEnListaCombinada(void*nod, void*&pedidosFinal){
    //La idea de este algoritmo es que inserteAlFinal
    void**lista=(void**)pedidosFinal;
    void**nodo=(void**)nod;
    //Ya tenemos nodo a apuntar, solo es insertarDeNuevo en Lista.
    void**ultimo=nullptr; //Hallamos el ultimo dato.
    void**recorrido=(void**)lista[0]; //Apunta al inicio;
    while(recorrido){
        ultimo=recorrido;
        recorrido=(void**)recorrido[1];
    }
    if(ultimo==nullptr){
        lista[0]=nod;
        lista[1]=nod;
    }else{
        ultimo[1]=nod;
        lista[1]=nod;
    }
}