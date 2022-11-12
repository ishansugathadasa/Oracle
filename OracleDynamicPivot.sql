--CREATING A TABLE

Create table PRODUCT(
Product varchar(255),
Dates int,
Sale int);

insert into PRODUCT(Product,Dates,Sale)
values('Prod1',2017,999999);
insert into PRODUCT(Product,Dates,Sale)
values('Prod2',2016,99999);
insert into PRODUCT(Product,Dates,Sale)
values('Prod3',2018,9999);


--######################################START PIVOT TABLE ###########################################
DECLARE
  sqlqry VARCHAR(1000);
  colmns VARCHAR(100);
BEGIN
  SELECT LISTAGG('''' || Dates || ''' as "' || Dates || '"', ',') WITHIN GROUP (ORDER BY Dates)
  INTO   colmns
  FROM   (SELECT DISTINCT Dates FROM PRODUCT);
  sqlqry :=
  '
  CREATE TABLE PRODUCT_PIVOT AS      
  SELECT * FROM
  (
      SELECT *
      FROM PRODUCT
  )
  PIVOT
  (
    MAX(Sale) FOR Dates IN (' || colmns  || ')
  )';

  EXECUTE IMMEDIATE sqlqry;
END;

--######################################END PIVOT TABLE ###########################################

SELECT * FROM PRODUCT_PIVOT
