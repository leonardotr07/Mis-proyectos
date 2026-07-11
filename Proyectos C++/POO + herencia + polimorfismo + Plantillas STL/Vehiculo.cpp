/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   Vehiculo.cpp
 * Author: Leonardo
 * 
 * Created on 24 de junio de 2025, 10:29 PM
 */
#include <iomanip>
#include <iostream>
#include <fstream>
#include <string>
using namespace std;
#include "Vehiculo.h"

Vehiculo::Vehiculo() {
}

Vehiculo::Vehiculo(const Vehiculo& orig) {
}

Vehiculo::~Vehiculo() {
}

void Vehiculo::SetCarga_actual(double carga_actual) {
    this->carga_actual = carga_actual;
}

double Vehiculo::GetCarga_actual() const {
    return carga_actual;
}

void Vehiculo::SetCarga_maxima(double carga_maxima) {
    this->carga_maxima = carga_maxima;
}

double Vehiculo::GetCarga_maxima() const {
    return carga_maxima;
}

void Vehiculo::SetPlaca(string placa) {
    this->placa = placa;
}

string Vehiculo::GetPlaca() const {
    return placa;
}

void Vehiculo::SetDni(int dni) {
    this->dni = dni;
}

int Vehiculo::GetDni() const {
    return dni;
}

void Vehiculo::leer(ifstream& archLectura) {
    char car;
    archLectura>>dni>>car;
    getline(archLectura, placa, ',');
    archLectura>>carga_maxima>>car;
    carga_actual=0.0;
}

void Vehiculo::mostrar(ofstream& archReporte) {
    archReporte<<left<<setw(25)<<"Codigo de Cliente: "<<right<<dni<<endl;
    archReporte<<left<<setw(25)<<"Placa: "<<right<<placa<<endl;
    archReporte<<left<<setw(25)<<"Carga Maxima: "<<right<<carga_maxima<<endl;
    archReporte<<left<<setw(25)<<"Carga Actual: "<<right<<carga_actual<<endl;
}
