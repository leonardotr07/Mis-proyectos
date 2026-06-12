/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   BibliotecaGenerica.h
 * Author: Leonardo
 *
 * Created on 4 de mayo de 2025, 03:19 PM
 */

#ifndef BIBLIOTECAGENERICA_H
#define BIBLIOTECAGENERICA_H

void crealista(void*&pedidos, void*(*leenum)(ifstream &), const char*nombArchCsv);
void insertarlista(void*dato, void*&pedidos);
void imprimirlista(void* pedidos, void(*imprimenum)(void*, ofstream &), const char*nombArchTxt);
void combinarLista(void*&pedidos1, void*&pedidos2, void*&pedidosFinal,
        int(*cmpnum)(void*, void*));
void colocarEnListaCombinada(void*nodo, void*&pedidosFinal);

#endif /* BIBLIOTECAGENERICA_H */

