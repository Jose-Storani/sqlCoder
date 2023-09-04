# Coderhouse curso MYSQL
## Base de datos para sistemas de facturación
### Descripción breve
Orientado a un sistema de facturación para empresa del rubro gastrónomico (especificamente café) en Argentina que comercializa dentro del territorio de la República.
Posee distintas sucursales dentro de la ciudad de origen (Rosario - Santa fe).

#### Pasos para setear la base de datos
1. Ejecutar el script "tableCreation.sql". Este contiene la creación de la base de datos con sus respectivas tablas.
2. Ejecutar el script "executionOrderInsertion.sql". Sirve de guía para la importación de los archivos **csv** y **json**, donde está toda la información a agregar a la BD.
3. Se deberán visualizar todas las tablas en pestañas separadas. Hacer click en orden para empezar con la inserción de datos.
4. En la carpeta data_to_insert, se encontraran todos los archivos para insertar, con su respectivo orden.
5. Durante la inserción, verificar que las columnas esten mapeadas correctamente.



### Vistas
#### Debts
Muestra número de factura, id de cliente, monto y fecha de todas las facturas que tengan la condición inpaga.

#### Last_year_invoices
Muestra id del cliente, nombre,  número de factura, monto y fecha de aquellas facturas correspondientes únicamente al año corriente, ordenadas de manera ascendente.

## Funciones
### unpayed_invoice
Recibe como parámetro un id de cliente. Devuelve el conteo de la cantidad de facturas impagas por dicho cliente.  
Funciona dentro de la lógica de negocio para bloquear la venta a aquellos clientes donde la función devuelva un valor mayor a 10.

## Stored Procedures
### InsertProduct
Recibe 7 parámetros de entrada con sus correspondientes tipados:

- product_code VARCHAR(255)
- brand_id TINYINT
- product_name VARCHAR(60)
- product_description TINYTEXT
- category_id TINYINT
- stock INT
- created_by_employee_id INT

Luego, inserta esos valores dentro de la tabla **Products**, completando así la creación de un nuevo producto.

### UpdateProductStock
Recibe dos parámetros de entrada

- product_code VARCHAR(255)
- new_stock_quantity INT

Actualiza el stock de productos en la tabla **Products**.


