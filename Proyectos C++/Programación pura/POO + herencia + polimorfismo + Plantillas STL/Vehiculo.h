/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   Vehiculo.h
 * Author: Leonardo
 *
 * Created on 24 de junio de 2025, 10:29 PM
 */

#ifndef VEHICULO_H
#define VEHICULO_H

class Vehiculo {
private:
    int dni;
    string placa;
    double carga_maxima;
    double carga_actual; //No puede exceder de la carga Maxima
public:
    Vehiculo();
    Vehiculo(const Vehiculo& orig);
    virtual ~Vehiculo();
    void SetCarga_actual(double carga_actual);
    double GetCarga_actual() const;
    void SetCarga_maxima(double carga_maxima);
    double GetCarga_maxima() const;
    void SetPlaca(string placa);
    string GetPlaca() const;
    void SetDni(int dni);
    int GetDni() const;
    virtual void leer(ifstream &archLectura);
    virtual void mostrar(ofstream &archReporte);
    virtual void insertar(ifstream &archLectura)=0;
};

#endif /* VEHICULO_H */

