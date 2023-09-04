use billingsystem;

create or replace view debts as
	(select invoice_number,client_id,amount,date 
    from invoice
    where status = "inpaga"
    order by date
    );
    
create or replace view last_year_invoices as
	(select id,name,invoice_number,amount,date 
    from invoice i join client c ON (c.id = i.client_id)
    where year(date) = YEAR(CURDATE())
    order by date);
    
   