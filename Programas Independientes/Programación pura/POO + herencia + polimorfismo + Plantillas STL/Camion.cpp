/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   Camion.cpp
 * Author: Leonardo
 * 
 * Created on 24 de junio de 2025, 10:30 PM
 */
#include <iomanip>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
using namespace std;
#include "Camion.h"

Camion::Camion() {
}

Camion::Camion(const Camion& orig) {
    *this=orig;
}

Camion::~Camion() {
}

void Camion::operator=(const Camion& orig) {
    llantas=orig.llantas;
    ejes=orig.ejes;
}

void Camion::SetLlantas(int llantas) {
    this->llantas = llantas;
}

int Camion::GetLlantas() const {
    return llantas;
}

void Camion::SetEjes(int ejes) {
    this->ejes = ejes;
}

int Camion::GetEjes() const {
    return ejes;
}

void Camion::leer(ifstream& archLectura) {
    char car;
    Vehiculo::leer(archLectura);
    archLectura>>ejes>>car>>llantas;
    archLectura.get();
}

void Camion::mostrar(ofstream& archReporte) {
    Vehiculo::mostrar(archReporte);
    archReporte<<left<<setw(25)<<"#Llantas: "<<right<<llantas<<endl;
    archReporte<<left<<setw(25)<<"#Ejes: "<<right<<ejes<<endl;
    if(depositos.empty()){
        archReporte<<"No hay pedidos para el cliente."<<endl;
    }else{
        //Recorremos el vector e imprimimos los Pedidos
        for (int i = 0; i < depositos.size(); i++) {
            depositos[i].imprimePedido(archReporte);
        }
    }
}
void Camion::insertar(ifstream& archLectura) {
    class Pedido datPedido;
    datPedido.leerDatosPedido(archLectura);
    if(depositos.size()<5 and GetCarga_actual()+datPedido.GetPeso()<=GetCarga_maxima()){
        depositos.push_back(datPedido);
        SetCarga_actual(GetCarga_actual()+datPedido.GetPeso());
    }
}
