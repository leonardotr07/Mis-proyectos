//A veces borraba el encabezado del proyecto...
#include <cstdlib>
#include <iostream>
#include <cmath>
#include <fstream>

using namespace std;

#include "Elemento.h"
#include "Nodo.h"
#include "Lista.h"
#include "funcionesLista.h"
void eliminarGuerrero(Lista &lista, int valorGuerreroBowser);
int contarPoderGuerreros(const Lista &bowser);
void imprimirListaYContarPoder(const Lista &lista, int &contadorPoder);
void simularBatallas(Lista &bowser, Lista &peach, Lista &donkeyKong, int n);
void imprimirLista(const Lista &lista);
void insertarGuerreros(Lista &bowser, Lista &peach, 
        Lista &donkeyKong, const Lista &listaGuerreros);
void insertarEnOrden(Lista &lista, Elemento elemento);
void fusionEjercitos(struct Lista& lista1, struct Lista &lista2);
int main(int argc, char** argv) {
	/*Vaya... Temática de la 1era Pelicula de Mario Bros
	
	Este problema de examen del curso de Algoritmia y Estructuras de Datos 
	plantea, con la temática de una batalla entre los ejércitos de Bowser,
	Peach y Donkey Kong, el manejo de listas simplemente enlazadas. Los 
	guerreros se ingresan en una única lista, donde cada valor de 3 
	dígitos codifica el nivel de ataque (2 primeros dígitos) y el 
	ejército al que pertenece (último dígito). A partir de ahí se deben 
	separar los guerreros en tres listas independientes, cada una ordenada 
	ascendentemente por nivel de ataque. Luego se simula una batalla por 
	turnos entre Bowser y Peach, comparando guerrero contra guerrero y 
	descontando al perdedor del total de ataque de su ejército; 
	las rondas se repiten reiniciando siempre desde el primer guerrero 
	hasta que uno de los dos ejércitos quede vacío. 
	
	Si en algún punto Peach va perdiendo, el ejército de Donkey Kong debe 
	fusionarse (una sola vez) con el de Peach manteniendo el orden ascendente,
	con la restricción de hacerlo in-place: complejidad O(n), sin usar new (memoria extra)
	y sin estructuras auxiliares. El examen pide implementar, en cuatro 
	partes, la carga de datos en la lista única, la separación/ordenamiento 
	por ejército, esta fusión restringida, y finalmente la lógica completa 
	de la simulación de batalla que determina al ganador.
	*/
    ifstream archLectura("datos.txt", ios::in);
    if(not archLectura.is_open()){
        cout<<"No se pudo abrir datos.txt";
    }
    struct Lista listaGuerreros;
    construir(listaGuerreros);
    int N, cantGuerreros;
    archLectura>>N>>cantGuerreros;
    struct Elemento elemento;
    while(true){
        archLectura>>elemento.valorGuerrero;
        insertarAlFinal(listaGuerreros, elemento.valorGuerrero);
        if(archLectura.eof()) break;
    }
    imprime(listaGuerreros);
    struct Lista bowser, peach, donkeyKong;
    construir(bowser), construir(peach), construir(donkeyKong);
    insertarGuerreros(bowser, peach, donkeyKong, listaGuerreros);
    simularBatallas(bowser, peach, donkeyKong, N);
    return 0;
}
void fusionEjercitos(struct Lista& lista1, struct Lista &lista2){
    //Fusionar listas... HECHO!
    Nodo*inicio=nullptr;
    Nodo*fin=nullptr;
    while(!esListaVacia(lista1) and !esListaVacia(lista2)){
        //Si el elemento de la Lista 1 es menor que la lista 2
        if(lista1.cabeza->elemento.poderGuerrero<=lista2.cabeza->elemento.poderGuerrero){
            //Si estamos en la primera iteracion.
            if(inicio==nullptr){
                inicio=lista1.cabeza;
                fin=lista1.cabeza;
            }else{
                fin->siguiente=lista1.cabeza;
                fin=fin->siguiente;
            }
            lista1.cabeza=lista1.cabeza->siguiente;
        }else{
            if(inicio==nullptr){
                inicio=lista2.cabeza;
                fin=lista2.cabeza;
            }else{
                fin->siguiente=lista2.cabeza;
                fin=fin->siguiente;
            }
            lista2.cabeza=lista2.cabeza->siguiente;
        }
    }
    if(esListaVacia(lista1)){
        fin->siguiente=lista2.cabeza;
    } else{
        fin->siguiente=lista1.cabeza;
    }
    lista1.cabeza=inicio;
    lista1.longitud=lista1.longitud+lista2.longitud;
}
void insertarGuerreros(Lista &bowser, Lista &peach, 
        Lista &donkeyKong, const Lista &listaGuerreros){
    Nodo*recorrido=listaGuerreros.cabeza;
    struct Elemento elemento;
    int poder, ejercito;
    while(recorrido!=nullptr){
        int valorGuerrero=recorrido->elemento.valorGuerrero;
        poder=valorGuerrero/10;
        ejercito=valorGuerrero%10;
        elemento.poderGuerrero=poder;
        elemento.ejercito=ejercito;
        if(elemento.ejercito==1) insertarEnOrden(bowser, elemento);
        else if (elemento.ejercito==2) insertarEnOrden(peach, elemento);
        else insertarEnOrden(donkeyKong, elemento);
        recorrido=recorrido->siguiente;
    }
}
void insertarEnOrden(Lista &lista, Elemento elemento){
    Nodo*anterior=obtenerNodoAnterior(lista, elemento.poderGuerrero);
    Nodo*nuevoNodo=crearNodo(elemento, nuevoNodo);
    
    if(anterior==nullptr){
        nuevoNodo->siguiente=lista.cabeza;
        lista.cabeza=nuevoNodo;
    }else{
        nuevoNodo->siguiente=anterior->siguiente;
        anterior->siguiente=nuevoNodo;
    }
    lista.longitud++;
}
void imprimirLista(const Lista &lista){
    struct Nodo*recorrido=lista.cabeza;
    if(recorrido==nullptr){
        cout<<"No se puede imprimir la lista si esta vacía.";
    }else 
        while(recorrido){
            cout<<recorrido->elemento.poderGuerrero;
            if(recorrido->siguiente!=nullptr) cout <<" -> ";
            recorrido=recorrido->siguiente;
        }
    cout<<endl;
}
void imprimirListaYContarPoder(const Lista &lista, int &contadorPoder){
    struct Nodo*recorrido=lista.cabeza;
    if(recorrido==nullptr){
        cout<<"No se puede imprimir la lista si esta vacía.";
    }else 
        while(recorrido){
            cout<<recorrido->elemento.poderGuerrero;
            if(recorrido->siguiente!=nullptr) cout <<" -> ";
            contadorPoder+=recorrido->elemento.poderGuerrero;
            recorrido=recorrido->siguiente;
        }
    cout<<endl;
}
void simularBatallas(Lista &bowser, Lista &peach, Lista &donkeyKong, int n){
    //Allasi, con todo respeto, que te fumaste?
    int poderBatallaBowser=0, poderBatallaPeach=0, poderBatallaDonkey=0; 
    cout<<"Los ejercitos formados son:"<<endl;
    cout<<"Ejercito 1 - Bowser: ";
    imprimirListaYContarPoder(bowser, poderBatallaBowser);
    cout<<"Nivel de Ataque Total del Ejercito 1: "<<poderBatallaBowser<<endl;
    cout<<endl<<"Ejercito 1 - Peach: "<<endl;
    imprimirListaYContarPoder(peach, poderBatallaPeach);    
    cout<<"Nivel de Ataque Total del Ejercito 2: "<<poderBatallaPeach<<endl;
    cout<<endl<<"Ejercito 1 - Donkey: "<<endl;
    imprimirListaYContarPoder(donkeyKong, poderBatallaDonkey);
    cout<<"Nivel de Ataque Total del Ejercito 3: "<<poderBatallaDonkey<<endl<<endl;
    
    cout<<"INICIA LA BATALLA:"<<endl;
    bool fusion=true;
    while(!esListaVacia(bowser) and !esListaVacia(peach)){
        cout<<"Ejercito 1 - Bowser: ", imprimirLista(bowser);
        cout<<"Ejercito 2 - Peach: ", imprimirLista(peach);
        Nodo*recorridoBowser=bowser.cabeza;
        Nodo*recorridoPeach=peach.cabeza;
        for (int i = 1; i <= n and (recorridoBowser) and (recorridoPeach); i++) {
            int valorGuerreroBowser=recorridoBowser->elemento.poderGuerrero;
            int valorGuerreroPeach=recorridoPeach->elemento.poderGuerrero;
            cout<<"Pelea "<<i<<": "<<valorGuerreroBowser<<" vs "<<valorGuerreroPeach<<", gana ";
            if(valorGuerreroBowser>valorGuerreroPeach){
                cout<<valorGuerreroBowser;
                eliminarGuerrero(peach, valorGuerreroPeach);
            } else{
                cout<<valorGuerreroPeach;
                eliminarGuerrero(bowser, valorGuerreroBowser);
            }
            cout<<endl;
            if(recorridoBowser->siguiente!=nullptr)recorridoBowser=recorridoBowser->siguiente;
            if(recorridoPeach->siguiente!=nullptr)recorridoPeach=recorridoPeach->siguiente;
        }
        poderBatallaBowser=contarPoderGuerreros(bowser);
        poderBatallaPeach=contarPoderGuerreros(peach);
        cout<<"Nivel de Ataque Total del Ejercito 1: "<<poderBatallaBowser<<endl;
        cout<<"Nivel de Ataque Total del Ejercito 2: "<<poderBatallaPeach<<endl;
        if(poderBatallaBowser>=poderBatallaPeach and fusion==true){
            fusionEjercitos(peach, donkeyKong);
            cout<<"El ejercito de Donkey Kong se une al ejercito de Peach"<<endl;
            fusion=false;
        }else{
            cout<<"Ya no se puede unir nadie al ejercito de Peach"<<endl;
        }
        cout<<endl;
    }
    if(esListaVacia(peach)) cout<<"Gana la batalla Bowser"<<endl;
    else cout<<"Gana la batalla Peach y Donkey Kong"<<endl;
}
int contarPoderGuerreros(const Lista &bowser){
    int poderTotal=0;
    Nodo*recorrido=bowser.cabeza;
    while(recorrido){
        poderTotal+=recorrido->elemento.poderGuerrero;
        recorrido=recorrido->siguiente;
    }
    return poderTotal;
}
void eliminarGuerrero(Lista &lista, int valorGuerreroBowser){
    struct Nodo*anterior=nullptr;
    struct Nodo*recorrido=lista.cabeza;
    
    while(recorrido!=nullptr and (recorrido->elemento.poderGuerrero != valorGuerreroBowser)){
        anterior=recorrido;
        recorrido=recorrido->siguiente;
    }
    
    if(recorrido!=nullptr){
        if(anterior==nullptr){ //Inicio de la lista.
            lista.cabeza=recorrido->siguiente;
        }else{
            anterior->siguiente=recorrido->siguiente;
        }
        delete recorrido;
        lista.longitud--;
    }
}