/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   Furgon.cpp
 * Author: Leonardo
 * 
 * Created on 24 de junio de 2025, 10:32 PM
 */
#include <iomanip>
#include <iostream>
#include <fstream>
#include <string>
#include <list>
using namespace std;
#include "Furgon.h"

Furgon::Furgon() {
}

Furgon::Furgon(const Furgon& orig) {
//    depositos=orig.depositos;
}

Furgon::~Furgon() {
}

void Furgon::SetPuertas(int puertas) {
    this->puertas = puertas;
}

int Furgon::GetPuertas() const {
    return puertas;
}

void Furgon::SetFilas(int filas) {
    this->filas = filas;
}

int Furgon::GetFilas() const {
    return filas;
}

void Furgon::leer(ifstream& archLectura) {
    char car;
    Vehiculo::leer(archLectura);
    archLectura>>filas>>car>>puertas;
    archLectura.get();
}

void Furgon::mostrar(ofstream& archReporte) {
    Vehiculo::mostrar(archReporte);
    archReporte<<left<<setw(25)<<"#Puertas: "<<right<<puertas<<endl;
    archReporte<<left<<setw(25)<<"#Filas: "<<right<<filas<<endl;
    if(depositos.empty()){
        archReporte<<"No hay pedidos para el cliente."<<endl;
    }else{
        //Recorro la lista.
        for (auto datPedido: depositos) {
            datPedido.imprimePedido(archReporte);
        }
    }
}

void Furgon::insertar(ifstream& archLectura) {
    class Pedido datPedido;
    datPedido.leerDatosPedido(archLectura);
    //InsertarOrdenado.
    if(GetCarga_actual()+datPedido.GetPeso()<=GetCarga_maxima()){
        depositos.push_back(datPedido);
        SetCarga_actual(GetCarga_actual()+datPedido.GetPeso());
    }
    cout<<datPedido.GetCodigo()<<' '<<datPedido.GetPeso()<<endl;
}

