
#include <cstdlib>
#include <iostream>
#include <cmath>

using namespace std;

#include "Flota.h"
int main(int argc, char** argv) {+
	/*Pregunta de examen desarrollada. Leer dos archivos CSV, 
	construir una jerarquía polimórfica de  vehículos dentro de 
	un mapa STL, asignarles sus pedidos respetando la capacidad de carga,
	y generar un reporte formateado, todo bajo diseño descendente y buenas 
	prácticas de encapsulamiento (sin arreglos auxiliares, sin variables 
	globales, etc., según las reglas generales del examen en su momento). 
	En este problema se usa STL vector, list y map*/
	
    Flota flota;
    flota.cargar_vehiculos("Vehiculos.csv");
    flota.mostrar_vehiculos("ReporteFlotaSinPed.txt");
    flota.cargar_pedidos("Pedidos4.csv");
    flota.mostrar_vehiculos("ReporteFlotaConPed.txt");
    return 0;
}

