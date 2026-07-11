/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   Flota.cpp
 * Author: Leonardo
 * 
 * Created on 24 de junio de 2025, 10:34 PM
 */
#include <iomanip>
#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <vector>
#include <list>
using namespace std;
#include "Camion.h"
#include "Furgon.h"
#include "Flota.h"

Flota::Flota() {
}

Flota::Flota(const Flota& orig) {
}

Flota::~Flota() {
}

void Flota::cargar_vehiculos(const char* nombArchCsv) {
    ifstream archLectura(nombArchCsv, ios::in);
    if(not archLectura.is_open()){
        cout<<"No se pudo abrir "<<nombArchCsv;
        exit(1);
    }
    //Cargar Vehiculos.csv
    class Vehiculo *datVehiculo;
    char tipo;
    while(true){
        archLectura>>tipo;
        if(archLectura.eof()) break;
        archLectura.get();
        if(tipo=='C') datVehiculo=new class Camion;
        else if(tipo=='F') datVehiculo=new class Furgon;
        datVehiculo->leer(archLectura); //Polimorfismo
        vehiculos.insert({datVehiculo->GetPlaca(), datVehiculo});
    }
}

void Flota::mostrar_vehiculos(const char* nombArchTxt) {
    ofstream archReporte(nombArchTxt, ios::out);
    if(not archReporte.is_open()){
        cout<<"No se pudo abrir "<<nombArchTxt;
        exit(1);
    }
    archReporte<<setw(70)<<"REPORTE DE FLOTA"<<endl;
    imprimirSimbolos(archReporte, '=');
    for (auto datVehiculo: vehiculos) {
        //Polimorfismo
        datVehiculo.second->mostrar(archReporte);
        imprimirSimbolos(archReporte, '-');
    }

}

void Flota::imprimirSimbolos(ofstream& archReporte, char car) {
    for (int i = 0; i < 120; i++) {
        archReporte.put(car);
    }
    archReporte<<endl;
}

void Flota::cargar_pedidos(const char* nombArchCsv) {
    ifstream archLectura(nombArchCsv, ios::in);
    if(not archLectura.is_open()){
        cout<<"No se pudo abrir "<<nombArchCsv;
        exit(1);
    }
    string placa;
//    class Vehiculo*datVehiculo;
    while(true){
        getline(archLectura, placa, ',');
        if(archLectura.eof()) break;
//        datVehiculo=buscarVehiculo(placa);
        
        vehiculos[placa]->insertar(archLectura);
        //Aqui es el problema
//        if(datVehiculo!=nullptr){
//            datVehiculo->insertar(archLectura);
//            cout<<datVehiculo->GetPlaca()<<endl;
//        }else while(archLectura.get()!='\n');
        
    }
}

class Vehiculo* Flota::buscarVehiculo(string placa) {
    for (auto &datVehiculo: vehiculos) {
        if(datVehiculo.first==placa) return datVehiculo.second;
    }
    return nullptr;
}
