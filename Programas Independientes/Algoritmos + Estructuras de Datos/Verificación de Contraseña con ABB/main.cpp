
#include <cstdlib>
#include <iostream>
#include <cmath>

#include "ArbolBB.h"
#include "funcionesAB.h"
#include "funcionesABB.h"

using namespace std;

bool verificarContrasenia(const ArbolBinarioBusqueda &arbolBB, const char*contraseniaUsuario);
bool estaEnLaPosicionCorrecta(const NodoArbol *raiz, char car, int posCar);
int buscarMayor(const ArbolBinarioBusqueda &arbolBB);
void buscaMayorR(const NodoArbol *raiz, int &posUltimo);
int main(int argc, char** argv) {
    //Bonito problema y divertido
	/*PSD del futuro: Me sigue pareciendo bonito 
	Este problema pide implementar en C++ un sistema de verificación de 
	contraseñas que, en lugar de almacenar la contraseña como una cadena 
	tradicional, la representa mediante un Árbol Binario de Búsqueda (ABB), 
	donde cada nodo guarda la posición del carácter dentro de la contraseña 
	(usada como clave de orden) y el carácter correspondiente. 
	Esta estructura debe construirse en el main(), tomando como ejemplo 
	la contraseña PUCP2024.
	
	El programa debe dar al usuario un máximo de N intentos para ingresar 
	la contraseña correcta. En cada intento se valida primero que la 
	longitud coincida, y luego se verifica cada carácter contra el ABB, 
	comprobando que exista en la contraseña y esté en la posición correcta;
	cualquier discrepancia hace fallar el intento. Si el usuario acierta 
	dentro del límite de intentos, se muestra "Acceso concedido"; 
	si los agota sin éxito, se muestra "Se llegó al número de intentos 
	fallidos permitidos". 
	
	La restricción central es que todas las operaciones sobre el ABB deben 
	implementarse de forma recursiva, sin usar arreglos, listas u otros TAD.
	
	PSD: Las librerias sobre el ABB dadas no fueron programadas por mí. 
	Como construir(), insertarNodo, etc. Por lo general se nos daban para 
	que solo las utilicemos. Pero si un problema lo requeria, se pueden 
	modificar las funciones o agregar nuevas funciones para lograr el 
	objetivo
	
	Además en el enunciado te daban como deberia estar distribuido el 
	arbol binario con las letras o números de la contraseña.
	*/
	
    ArbolBinarioBusqueda arbolBB;
    construir(arbolBB);
    
    //Se recourre en Orden.
    Elemento elemento;
    
    elemento.posicionLetra=4;
    elemento.letra='P';
    insertar(arbolBB, elemento);
    
    elemento.posicionLetra=2;
    elemento.letra='U';
    insertar(arbolBB, elemento);
    
    elemento.posicionLetra=6;
    elemento.letra='0';
    insertar(arbolBB, elemento);
    
    elemento.posicionLetra=1;
    elemento.letra='P';
    insertar(arbolBB, elemento);
    
    elemento.posicionLetra=3;
    elemento.letra='C';
    insertar(arbolBB, elemento);
    
    elemento.posicionLetra=5;
    elemento.letra='2';
    insertar(arbolBB, elemento);
    
    elemento.posicionLetra=7;
    elemento.letra='2';
    insertar(arbolBB, elemento);
    
    elemento.posicionLetra=8;
    elemento.letra='4';
    insertar(arbolBB, elemento);
    
//    enOrden(arbolBB);
    
    int numIntentos;
    cout<<"Ingrese el número máximo de intentos: ";
    cin>>numIntentos;
    cout<<endl;
    char contraseniaUsuario[10];
    bool esContrasenia=false;
    for (int i = 1; i <= numIntentos; i++) {
        cout<<"Intento "<<i<<". Ingrese la contraseña: ";
        cin>>contraseniaUsuario;
        esContrasenia=verificarContrasenia(arbolBB, contraseniaUsuario);
        if(esContrasenia){
            cout<<"Acceso concedido."<<endl;
            break;
        }else{
            if(i==numIntentos){
                cout<<"Se llegó al número de intentos fallidos permitidos. "<<endl;
                break;
            }
            cout<<"Contraseña incorrecta. Intento Fallido."<<endl;
        }
    }
    return 0;
}
bool verificarContrasenia(const ArbolBinarioBusqueda &arbolBB, const char*contraseniaUsuario){
    //Primer requisito longitud de la palabra.
    //Como los elementos del arbol tienen "ID" o numero de orden, sería hallar el que posee mayor orden.
    int longitud=buscarMayor(arbolBB);
    int longitudCadenaIngresada;
    for (longitudCadenaIngresada = 0; contraseniaUsuario[longitudCadenaIngresada]; longitudCadenaIngresada++);
    if(longitud!=longitudCadenaIngresada) return false;
    
    //Si tienen la misma longitud...
    //Recorremos la cadena
    for (int i = 0; contraseniaUsuario[i]; i++) {
        if(!estaEnLaPosicionCorrecta(arbolBB.arbolBinario.raiz, contraseniaUsuario[i], i+1)) return false;
    }
    return true; //Es la contraseña.
}
bool estaEnLaPosicionCorrecta(const NodoArbol *raiz, char car, int posCar){
    if(raiz==nullptr) return false; //No se encuentra en el arbol.
    if(raiz->elemento.posicionLetra==posCar and raiz->elemento.letra==car) return true;
    if(posCar<raiz->elemento.posicionLetra)
        return estaEnLaPosicionCorrecta(raiz->izquierda, car, posCar);
    else
        return estaEnLaPosicionCorrecta(raiz->derecha, car, posCar);
}
//Tiene que ser recursivo.
int buscarMayor(const ArbolBinarioBusqueda &arbolBB){
    int posUltimo;
    buscaMayorR(arbolBB.arbolBinario.raiz, posUltimo);
    return posUltimo;
}
void buscaMayorR(const NodoArbol *raiz, int &posUltimo){
    if(raiz->derecha==nullptr){
        if(raiz->izquierda){
            raiz=raiz->izquierda;
        }else{
            posUltimo=raiz->elemento.posicionLetra;
            return;
        }
    }
    buscaMayorR(raiz->derecha, posUltimo);
}