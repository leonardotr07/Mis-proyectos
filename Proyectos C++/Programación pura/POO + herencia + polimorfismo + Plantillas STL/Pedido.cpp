/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   Pedido.cpp
 * Author: Leonardo
 * 
 * Created on 24 de junio de 2025, 10:22 PM
 */
#include <iomanip>
#include <iostream>
#include <fstream>
#include <string>
using namespace std;
#include "Pedido.h"

Pedido::Pedido() {
    cantidad=0;
    codigo="a";
    peso=0;
}

Pedido::Pedido(const Pedido& orig) {
    *this=orig;
}

Pedido::~Pedido() {
}

void Pedido::operator=(const Pedido& orig) {
    
    //Clave, sino no imprime datos de Pedido. NO BORRAR.
    cantidad=orig.cantidad;
    codigo=orig.codigo;
    peso=orig.peso;
}

void Pedido::SetPeso(double peso) {
    this->peso = peso;
}

double Pedido::GetPeso() const {
    return peso;
}

void Pedido::SetCantidad(int cantidad) {
    this->cantidad = cantidad;
}

int Pedido::GetCantidad() const {
    return cantidad;
}

void Pedido::SetCodigo(string codigo) {
    this->codigo = codigo;
}

string Pedido::GetCodigo() const {
    return codigo;
}

bool Pedido::operator<(const Pedido& orig) const {
    return peso<orig.peso;
}

void Pedido::leerDatosPedido(ifstream& archLectura) {
    char car;
    getline(archLectura, codigo, ',');
    archLectura>>cantidad>>car>>peso;
    archLectura.get();
}

void Pedido::imprimePedido(ofstream& archReporte) const {
    archReporte<<codigo<<' '<<peso<<setw(5)<<cantidad<<endl;
}
