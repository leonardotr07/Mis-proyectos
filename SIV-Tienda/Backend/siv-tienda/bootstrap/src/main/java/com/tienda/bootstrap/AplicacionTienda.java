/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.bootstrap;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

/**
 *
 * @author Leonardo
 */

//Autoconfigura JPA o Web según las dependencias. Además de buscar componentes en el paquete actual y subpaquetes.
@SpringBootApplication
@ComponentScan(basePackages="com.tienda") //Los packages que estan relacionados tienen como base: com.tienda

public class AplicacionTienda {
    public static void main(String[] args){
        //Método que inicia el servidor web (Tomcat). Gracias a esto la app escuchará peticiones HTTP
        //Es encender el servidor.
        SpringApplication.run(AplicacionTienda.class, args);
    }
}
