#include <stdio.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char*argv[]){
	//Realizar un anillo de procesos. 
	//Recibe como argumento el mensaje a recibir... y el numero de procesos que consiste el anillo
	pid_t hijo, pidOriginal;
	char* mensaje=argv[1];
	int nProcesos=atoi(argv[2]);
	int fd[2], i;
	
	if(argc!=3){
		fprintf(stderr, "Ejecutar el comando de la siguiente manera: ./anillo <mensaje> <cantProcesos del anillo>");
		exit(1);
	}
	
	pipe(fd);
	//Reemplazamos su salida y entrada estandar
	dup2(fd[0], STDIN_FILENO);
	dup2(fd[1], STDOUT_FILENO);
	close(fd[0]);
	close(fd[1]);
	
	pidOriginal=getpid();
	
	for(i=0; i<nProcesos-1; i++){
		pipe(fd);
		hijo=fork();
		if(hijo>0){
			//Código del padre
			//Reasignamos la salida estandar
			dup2(fd[1], STDOUT_FILENO);
		}else{
			//Código del hijo.
			//Reasignamos la entrada estandar
			dup2(fd[0], STDIN_FILENO);
		}
		close(fd[0]);
		close(fd[1]);
		if(hijo) break; //Si es el padre... Rompe la iteración
	}
	
	fprintf(stderr, "Este es el proceso %d con ID: %ld y padre %ld\n", i,
	 (long)getpid(), (long) getppid());
	
	if(pidOriginal==getpid()){
		write(STDOUT_FILENO, mensaje, strlen(mensaje)+1);
		char buffer[256];
		read(STDIN_FILENO, buffer, sizeof(buffer));
		fprintf(stderr, "Mensaje recibido de vuelta: %s\n", buffer);
	} else {
		char buffer[256];
		read(STDIN_FILENO, buffer, sizeof(buffer));
		write(STDOUT_FILENO, buffer, strlen(buffer)+1);
	}
	
	return 0;
}

