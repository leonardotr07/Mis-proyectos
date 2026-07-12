/*
Descripción del problema:

El programa comentado de killer.c ha sido elaborado por Gemini con el siguiente 
prompt: "Elabora un programa en lenguaje C tal que el proceso cree n procesos hijos.
Luego el proceso padre de forma aleatoria elija un número entre 1 y n. El número
elegido es el proceso que antes de terminar se encargará de eliminar uno a uno
todos los procesos creados excepto el padre."

Analice el programa... Y comentar si el programa cumple su objetivo o no. 
Si es correcto... como se puede mejorar?
Si no es correcto... explicar por qué es correcto?

Para compilar el archivo: gcc -o killer killer.c
Ejecutar: ./killer

Código original de killer.c hecho por Gemini:
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <signal.h>
#include <time.h>

#define N 5 // Número de procesos hijos a crear

// Variable global para almacenar los PIDs de los hijos
pid_t pids[N];
// Bandera para indicar al hijo si ha sido seleccionado
volatile sig_atomic_t selected_to_kill = 0;

// Manejador de señales para el hijo elegido
void sig_handler(int signum) {
    if (signum == SIGUSR1) {
        selected_to_kill = 1;
    }
}

int main() {
    int i;
    srand(time(NULL));

    // Configuración del manejador de señales para todos los procesos antes de fork
    struct sigaction sa;
    sa.sa_handler = sig_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;
    sigaction(SIGUSR1, &sa, NULL);

    // Bucle para crear N procesos hijos
    for (i = 0; i < N; i++) {
        pids[i] = fork();

        if (pids[i] == -1) {
            perror("fork");
            return 1;
        }

        if (pids[i] == 0) { // Código del proceso hijo
            printf("Proceso hijo creado con PID: %d\n", getpid());
            
            // Los hijos esperan la señal para ser seleccionados
            while(!selected_to_kill) {
                pause(); // Pausa la ejecución hasta que se reciba una señal
            }
            
            printf("Proceso %d ha sido elegido para eliminar a los demás.\n", getpid());
            
            // Proceso "asesino" elimina a los demás hijos
            for(int j = 0; j < N; j++) {
                if (pids[j] != getpid()) {
                    printf("  -> Proceso %d eliminando a proceso %d\n", getpid(), pids[j]);
                    kill(pids[j], SIGKILL); // Envía la señal de terminación forzada
                }
            }
            
            printf("Proceso %d ha terminado su tarea y se autodestruye.\n", getpid());
            exit(0);
        }
    }

    // Código del proceso padre
    printf("Proceso padre con PID: %d\n", getpid());
    
    // El padre elige un hijo al azar para que sea el asesino
    int killer_index = rand() % N;
    pid_t killer_pid = pids[killer_index];
    
    printf("El padre ha elegido al proceso con PID: %d para ser el 'asesino'.\n", killer_pid);
    
    // El padre envía una señal SIGUSR1 al proceso hijo elegido
    kill(killer_pid, SIGUSR1);
    
    // El padre espera a que todos sus hijos terminen
    for (i = 0; i < N; i++) {
        wait(NULL);
    }
    
    printf("Todos los procesos hijos han terminado. El padre finaliza.\n");
    return 0;
}
*/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <signal.h>
#include <time.h>

#define N 5 // Número de procesos hijos a crear

// Variable global para almacenar los PIDs de los hijos
pid_t pids[N];
// Bandera para indicar al hijo si ha sido seleccionado
volatile sig_atomic_t selected_to_kill = 0;

// Manejador de señales para el hijo elegido
void sig_handler(int signum) {
    if (signum == SIGUSR1) {
        selected_to_kill = 1;
    }
}

int main() {
    int i;
    int fd_pipe[2];
    
    pipe(fd_pipe);
    srand(time(NULL));

    // Configuración del manejador de señales para todos los procesos antes de fork
    struct sigaction sa;
    sa.sa_handler = sig_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;
    sigaction(SIGUSR1, &sa, NULL);

    // Bucle para crear N procesos hijos
    for (i = 0; i < N; i++) {
		//Comentario 1:
		//Para el padre... tendra todos los pids[i], sin embargo para el hijo que matará a
		//sus hermanos no tendrá esta información... Se necesita de un pipe para generar esta comunicación.
        pids[i] = fork();

        if (pids[i] == -1) {
            perror("fork");
            return 1;
        }

        if (pids[i] == 0) { // Código del proceso hijo
            printf("Proceso hijo creado con PID: %d\n", getpid());
            
            // Los hijos esperan la señal para ser seleccionados
            while(!selected_to_kill) {
				printf("Proceso pid con hijo %d pausado.\n", getpid());
				fflush(stdout);
                pause(); // Pausa la ejecución hasta que se reciba una señal
            }
            
            printf("Proceso %d ha sido elegido para eliminar a los demás.\n", getpid());
            int victima;
            // Proceso "asesino" elimina a los demás hijos
            for(int j = 0; j < N; j++) {
				//Comentario 2:
				//Se descarta la opcion de que sea con "pid 0" ya que mataria a todos los procesos del grupo incluido al padre.
				read(fd_pipe[0], &victima, sizeof(victima));
                if (victima != getpid() && victima!=0) {
                    printf("  -> Proceso %d eliminando a proceso %d\n", getpid(), victima);
                    kill(victima, SIGKILL); // Envía la señal de terminación forzada
                }
            }
            
            printf("Proceso %d ha terminado su tarea y se autodestruye.\n", getpid());
            close(fd_pipe[0]); //Lectura cerrado
			close(fd_pipe[1]); //Escritura cerrado
            exit(0);
        }else{
			//Por parte del padre... Almacena los pids de los hijos en el pipe.
			write(fd_pipe[1], &pids[i], sizeof(pids[i]));
		}
    }
	//Cerramos los file descriptors
	close(fd_pipe[0]); //Lectura cerrado
	close(fd_pipe[1]); //Escritura cerrado
    // Código del proceso padre
    printf("Proceso padre con PID: %d\n", getpid());
    
    // El padre elige un hijo al azar para que sea el asesino
    int killer_index = rand() % N;
    pid_t killer_pid = pids[killer_index];
    
    printf("El padre ha elegido al proceso con PID: %d para ser el 'asesino'.\n", killer_pid);
    
    // El padre envía una señal SIGUSR1 al proceso hijo elegido
    kill(killer_pid, SIGUSR1);
    
    // El padre espera a que todos sus hijos terminen
    for (i = 0; i < N; i++) {
        wait(NULL);
    }
    
    printf("Todos los procesos hijos han terminado. El padre finaliza.\n");
    return 0;
}
/*Explicación: 
El problema cumple pero no del todo lo solicitado. Debido a que existen casos
 * en los que el hijo asesino no logra matar a todos los hijos debido a que la unidad
 * de almacenamiento (Variable global pids) no es compartida con el padre.
 * Solo contiene lo que el padre actualizó antes que él. Por lo que si el hijo asesino es el último
 * deberia de matar a todos sus hermanos. y lograr lo solicitado. Pero este caso es 1 entre N
 * por no es muy probable q pase... Pareceria que cumple con lo solicitado debido a que al final
 * el hijo asesino mata a todos los procesos usando kill(0, SIGKILL) debido a que el arreglo
 * global tiene 0 como inicializacion.... Por ende sale la bandera de KILLED. Pero lo que hace
 * es que mata a todos los hermanos y al padre (Todos los procesos que pertenecen a su mismo grupo).
 Esto último es del comportamiento del código generado por Gemini*/


