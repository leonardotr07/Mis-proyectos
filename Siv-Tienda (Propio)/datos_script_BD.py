#Cargamos el controlador de PostgreSQL
import psycopg2

#Definimos la función conectar, el cual es la que intenta conectarse a la BD
def conectar():
    try:
        conexion = psycopg2.connect(
            host="ep-morning-pine-ah6j7c5m.c-3.us-east-1.aws.neon.tech",
            database="neondb",
            user="neondb_owner",
            password="npg_kuKqDwRm5Wv8",
            sslmode="require"
        )
        #Conexion existosa si se logra conectar
        print("Conexion exitosa")
        return conexion
        #Si ocurre una excepción en la conexión: Error al conectar
    except Exception as e:
        print("Error al conectar:", e)
        return None

#Funcion InsertarProductos recibe la conexión con la BD
def insertar_productos(conexion):
    try:
        #Crea un cursor para las consultas SQL
        cursor = conexion.cursor()
        #Arreglo que contiene los productos con sus atributos (Mismos que en la tabla)
        #nombre, descripcion, precio, stock, stock_minimo
        productos = [
            ("Polo Manga Larga Rojo", "Polo de algodon, talla M, color rojo", 45.90, 20, 5),
            ("Polo Manga Corta Azul", "Polo de algodon, talla S, color azul marino", 35.50, 25, 4),
            ("Polo Cuello V Negro", "Polo de algodon, talla L, color negro", 42.00, 18, 3),
            ("Polo Rayado Blanco", "Polo con rayas horizontales, talla M, blanco con azul", 48.00, 15, 4),
            ("Polo Estampado Verde", "Polo con estampado floral, talla S, color verde", 39.90, 12, 3),
            
            # Jeans
            ("Jeans Azul Claro", "Jeans recto, tela resistente, talle 32", 89.50, 15, 3),
            ("Jeans Negro", "Jeans ajustado, talle 30, color negro", 95.00, 12, 2),
            ("Jeans Gris", "Jeans slim fit, talle 34, color gris", 85.00, 10, 3),
            ("Jeans Claro Desgastado", "Jeans con efecto desgastado, talle 28", 99.00, 8, 2),
            ("Jeans Azul Oscuro", "Jeans clasico, talle 36, color azul oscuro", 92.50, 14, 4),
            
            # Casacas y chaquetas
            ("Casaca Impermeable Negra", "Casaca para lluvia, talla L", 120.00, 10, 2),
            ("Chaqueta de Cuero Marron", "Chaqueta de cuero sintetico, talla M", 150.00, 8, 2),
            ("Casaca Ligera Beige", "Casaca de nylon, talla S, color beige", 65.00, 12, 3),
            ("Chaqueta Jean Azul", "Chaqueta de mezclilla, talla L, color azul", 110.00, 9, 2),
            ("Casaca Deportiva Roja", "Casaca rompevientos, talla M, color rojo", 55.00, 15, 4),
            
            # Zapatillas
            ("Zapatillas Deportivas Blancas", "Zapatillas para correr, numero 40", 75.00, 8, 2),
            ("Zapatillas Negras", "Zapatillas casuales, numero 42, color negro", 65.00, 12, 3),
            ("Zapatillas Azules", "Zapatillas de tela, numero 38, color azul", 58.00, 10, 2),
            ("Zapatillas Grises", "Zapatillas urbanas, numero 41, color gris", 70.00, 9, 3),
            ("Zapatillas Rosadas", "Zapatillas deportivas, numero 36, color rosado", 72.00, 7, 2),
            
            # Gorras y accesorios
            ("Gorra Unisex Azul", "Gorra de algodon color azul marino", 25.00, 30, 5),
            ("Gorra Negra", "Gorra de algodon color negro", 22.00, 28, 5),
            ("Gorra Roja", "Gorra de algodon color rojo", 20.00, 25, 4),
            ("Bufanda de Lana Gris", "Bufanda de lana, color gris", 18.00, 15, 3),
            ("Guantes de Cuero Negro", "Guantes de cuero, talla M", 30.00, 10, 2),
            
            # Otras prendas
            ("Camisa Formal Blanca", "Camisa de vestir, talla M, color blanco", 55.00, 12, 3),
            ("Camisa Cuadros Roja", "Camisa de cuadros, talla L, rojo y negro", 50.00, 10, 2),
            ("Vestido Primavera", "Vestido de flores, talla S, multicolor", 85.00, 8, 2),
            ("Short Deportivo Negro", "Short para gym, talla M, color negro", 35.00, 20, 4),
            ("Buzo Canguro Gris", "Buzo con capucha, talla L, color gris", 60.00, 12, 3)
            
            # Productos Críticos (Stock < Stock_minimo)
            ("Polo Critico Rojo", "Polo de algodon, talla S, rojo", "POLOS", 25.00, 2, 5),
            ("Jeans Critico Azul", "Jeans recto, talle 28", "JEANS", 70.00, 1, 4),
            ("Casaca Critica Negra", "Casaca para lluvia, talla M", "CASACAS", 90.00, 0, 3),
            ("Zapatilla Critica Blanca", "Zapatilla deportiva, numero 39", "ZAPATILLAS", 60.00, 3, 6),
            ("Gorra Critica Roja", "Gorra de algodon roja", "ACCESORIOS", 15.00, 2, 5),
            ("Vestido Critico Verde", "Vestido de flores, talla M", "VESTIDOS", 65.00, 1, 4),
            ("Buzo Critico Azul", "Buzo con capucha, talla L", "VESTIDOS", 55.00, 2, 5),
            ("Short Critico Negro", "Short para gym, talla S", "VESTIDOS", 30.00, 0, 3),
            ("Chaqueta Critica Marron", "Chaqueta de cuero, talla L", "CASACAS", 130.00, 1, 4),
            ("Camisa Critica Blanca", "Camisa formal, talla S", "VESTIDOS", 50.00, 2, 5),
        ]
        #Recorre cada producto definido. (Parece un try - catch)
        for p in productos:
            #Por cada producto ejecuta INSERT INTO productos ... 
            cursor.execute(
            "INSERT INTO productos (nombre, descripcion, precio, stock, stock_minimo) VALUES (%s, %s, %s, %s, %s)",
            (p[0], p[1], p[2], p[3], p[4])
            )
        #Commit para confirmar cambios
        conexion.commit()
        #Imprime el producto insertado
        print("Se insertaron", len(productos), "productos correctamente")
        #Cierra la escritura de Sentencias SQL
        cursor.close()
        #Imprime el producto insertado
        print("Se insertaron", len(productos), "productos correctamente")
        #Cierra la escritura de Sentencias SQL
        cursor.close()
    except Exception as e: #Si ocurriera una excepción o una falla inesperada
        #Error al insertar... y rollback, revirtiendo todos los cambios realizados
        print("Error al insertar:", e)
        conexion.rollback()
            
    #El script se ejecuta solo si llamamos directamente al programa
if __name__ == "__main__":
    conexion = conectar()
if conexion is not None: #Si la conexion no es vacia
    insertar_productos(conexion)
    conexion.close()