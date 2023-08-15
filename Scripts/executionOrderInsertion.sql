select * from branch;

select * from employee;

select * from fiscal_condition;

select * from location;

select * from client;

select * from brand;

select * from category;

select * from products;

select * from payment_method;

select * from invoice;

select * from invoice_products_detail;

select * from products_stored;

#luego de hacer todas las inserciones desde los archivos csv y json, es necesario commit para guardar los cambios en la BD
COMMIT;
