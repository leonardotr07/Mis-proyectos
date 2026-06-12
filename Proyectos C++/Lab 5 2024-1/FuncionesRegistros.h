/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   FuncionesRegistros.h
 * Author: Leonardo
 *
 * Created on 4 de mayo de 2025, 03:20 PM
 */

#ifndef FUNCIONESREGISTROS_H
#define FUNCIONESREGISTROS_H

void* leeregistro(ifstream &archLectura);
char*leerCadenaExacta(ifstream &archLectura, char carFinal);
void imprimeregistro(void*dato, ofstream &archReporte);
int cmpregistro(void*dato1, void*dato2);

#endif /* FUNCIONESREGISTROS_H */

