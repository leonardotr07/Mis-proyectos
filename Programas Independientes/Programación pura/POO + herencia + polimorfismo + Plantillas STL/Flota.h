/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   Flota.h
 * Author: Leonardo
 *
 * Created on 24 de junio de 2025, 10:34 PM
 */

#ifndef FLOTA_H
#define FLOTA_H
#include <map>
#include "Vehiculo.h"
class Flota {
private:
    map<string, class Vehiculo*>vehiculos;//Punteros? esta interesante...
public:
    Flota();
    Flota(const Flota& orig);
    virtual ~Flota();
    void cargar_vehiculos(const char*nombArchCsv);
    void mostrar_vehiculos(const char*nombArchTxt);
    void imprimirSimbolos(ofstream &archReporte, char car);
    void cargar_pedidos(const char*nombArchCsv);
    Vehiculo*buscarVehiculo(string placa);
};

#endif /* FLOTA_H */

