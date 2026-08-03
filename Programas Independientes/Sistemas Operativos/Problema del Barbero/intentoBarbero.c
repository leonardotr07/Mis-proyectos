#include <fcntl.h>
#include <semaphore.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
#include <signal.h>

#define SHM_NOMBRE "/Datos"
#define SEM_NOMBRE "/Mutex"
#define SEM_CLIENTES "/clientes"
#define SEM_BARBERO "/barbero"
#define SEM_SYNC "/Sync"
#define SHM_TAMANIO sizeof(int)
#define MAX_SILLAS 10
#define CANT_CLIENTES 20

struct datos{
	int sillasTomadas;
	int cantClientesAtendidos;
};

int main(void){
	
	/*Hice la implementación de este problema del bárbero dormilón en C para
	repasar para un laboratorio sobre semaforos. 
	
	Este es un problema clásico de concurencia entre procesos.
	
	En este caso los clientes son los procesos hijos y el barbero es el proceso 
	padre o principal. Para esta solución se emplean semáforos junto con 
	un segmento compartido
	
	El barbero podra atender a 1 cliente a la vez. Si un cliente llega y 
	el barbero esta ocupado. Espera en las sillas disponibles. Si no hay sillas
	se marcha.*/
	
	sem_t *mutex=sem_open(SEM_NOMBRE, O_CREAT, 0666, 1);
	sem_t *clientes=sem_open(SEM_CLIENTES, O_CREAT, 0666, 0); //Empieza en 0, ya que no hay clientes
	sem_t *barbero=sem_open(SEM_BARBERO, O_CREAT, 0666, 0); //Empieza en 0, ya que nadie es atendido.
	sem_t *sync=sem_open(SEM_SYNC, O_CREAT, 0666, 0);
	int fd=shm_open(SHM_NOMBRE, O_CREAT | O_RDWR, 0666);
	
	
	if(fd==-1){
		perror("shm_open");
		exit(EXIT_FAILURE);
	}
	if(mutex==SEM_FAILED){
		perror("sem_open");
		exit(EXIT_FAILURE);
	}
	if(clientes==SEM_FAILED){
		perror("sem_open");
		exit(EXIT_FAILURE);
	}
	if(barbero==SEM_FAILED){
		perror("sem_open");
		exit(EXIT_FAILURE);
	}
	if(sync==SEM_FAILED){
		perror("sem_open");
		exit(EXIT_FAILURE);
	}
	
	ftruncate(fd, SHM_TAMANIO);
	struct datos *ptr=mmap(NULL, SHM_TAMANIO, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if(ptr==MAP_FAILED){
		perror("mmap");
		exit(EXIT_FAILURE);
	}
	ptr->cantClientesAtendidos=0;
	ptr->sillasTomadas=0;
	pid_t pid;
	
	for(int i=0; i<CANT_CLIENTES; i++) if(!(pid=fork())) break;
	
	if(!pid){
		//Código de los clientes
		//Esperamos a que los hijos terminen de crearse
		sem_wait(sync);
		sem_wait(mutex);
		if(ptr->sillasTomadas<MAX_SILLAS){
			ptr->sillasTomadas++;
			sem_post(clientes); //Indica que hay un cliente esperando.
			sem_post(mutex);
			sem_wait(barbero); //Indica q toma al barbero.
			printf("El cliente con PID [%d] va a ser atendido.\n", (int)getpid());
		}else{
			sem_post(mutex); //Se va.
		}
		sem_close(clientes);
		sem_close(mutex);
		sem_close(barbero);
		sem_close(sync);
		munmap(ptr, SHM_TAMANIO);
		exit(0);
	}
	//Código del padre. (Barbero)
	//Despertamos a todos los hijos.
	for(int i=0; i<CANT_CLIENTES; i++) sem_post(sync);
	//Para que termine el programa pondre un límite.
	for(;;){
		sem_wait(clientes); //Duerme si no hay clientes por atender.
		sem_wait(mutex);
		ptr->sillasTomadas--; //Se libera una silla.
		sem_post(mutex);
		sem_post(barbero); //Se libera el barbero. Listo para atender a otro cliente..
		
		//Imprimira el numero de clientes atendidos después de atender a un cliente.
		printf("El barbero con PID [%d] corta cabello a cliente. Van %d clientes atendidos.\n", (int)getpid(), ptr->cantClientesAtendidos+1);
		ptr->cantClientesAtendidos++;
	}
	return 0;
}
