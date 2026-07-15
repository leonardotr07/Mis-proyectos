/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   Furgon.h
 * Author: Leonardo
 *
 * Created on 24 de junio de 2025, 10:32 PM
 */

#ifndef FURGON_H
#define FURGON_H
#include "Pedido.h"
#include "Vehiculo.h"
class Furgon: public Vehiculo {
private:
    int filas;
    int puertas;
    list<class Pedido>depositos; //Ordenados por peso, debe tener operador.
public:
    Furgon();
    Furgon(const Furgon& orig);
    virtual ~Furgon();
    void SetPuertas(int puertas);
    int GetPuertas() const;
    void SetFilas(int filas);
    int GetFilas() const;
    void leer(ifstream &archLectura);
    void mostrar(ofstream &archReporte);
    void insertar(ifstream &archLectura);
};

#endif /* FURGON_H */

