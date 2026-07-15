package com.tienda.infraestructura.configuracion;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@Configuration
@EnableJpaRepositories(basePackages = "com.tienda.infraestructura.adaptador.repositorio")
@EntityScan(basePackages = "com.tienda.infraestructura.entidad")
public class JpaConfig {
    // Esta clase solo sirve para activar el escaneo de repositorios y entidades
}