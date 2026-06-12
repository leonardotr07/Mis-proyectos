/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   FuncionesEnteras.h
 * Author: Leonardo
 *
 * Created on 4 de mayo de 2025, 03:20 PM
 */

#ifndef FUNCIONESENTERAS_H
#define FUNCIONESENTERAS_H

void* leenum(ifstream &archLectura);
void imprimenum(void*dato, ofstream &archReporte);
int cmpnum(void*dato1, void*dato2);

#endif /* FUNCIONESENTERAS_H */

