/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   Pedido.h
 * Author: Leonardo
 *
 * Created on 24 de junio de 2025, 10:22 PM
 */

#ifndef PEDIDO_H
#define PEDIDO_H

class Pedido {
private:
    string codigo;
    int cantidad;
    double peso;
public:
    Pedido();
    Pedido(const Pedido& orig);
    virtual ~Pedido();
    void SetPeso(double peso);
    double GetPeso() const;
    void SetCantidad(int cantidad);
    int GetCantidad() const;
    void SetCodigo(string codigo);
    string GetCodigo() const;
    bool operator<(const Pedido& orig) const;
    void leerDatosPedido(ifstream &archLectura);
    void imprimePedido(ofstream &archReporte) const;
    void operator=(const class Pedido&orig);
};

#endif /* PEDIDO_H */

