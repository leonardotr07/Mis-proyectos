/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   Camion.h
 * Author: Leonardo
 *
 * Created on 24 de junio de 2025, 10:30 PM
 */

#ifndef CAMION_H
#define CAMION_H
#include "Pedido.h"
#include "Vehiculo.h"
class Camion: public Vehiculo {
private:
    int ejes;
    int llantas;
    vector<class Pedido>depositos; //Como maximo debe haber 5
public:
    Camion();
    Camion(const Camion& orig);
    virtual ~Camion();
    void SetLlantas(int llantas);
    int GetLlantas() const;
    void SetEjes(int ejes);
    int GetEjes() const;
    void leer(ifstream &archLectura);
    void mostrar(ofstream &archReporte);
    void insertar(ifstream &archLectura);
    void operator=(const class Camion &orig);
};

#endif /* CAMION_H */

