CREATE TABLE goods (
    id int not null primary key,
    warehouseId int not null,
    productId int not null,
    quantity int
);

CREATE TABLE warehouse (
    id int not null primary key,
    name varchar(100)
);

CREATE TABLE product (
    id int not null primary key,
    name varchar(100),
    brendId int not null
);
DROP TABLE  PRODUCT;

CREATE TABLE brand (
    id int not null primary key,
    name varchar(100),
    contry varchar(100)
);

insert INTO BRAND (ID, "NAME", CONTRY) VALUES (0, 'NIKE', 'RU');
insert INTO BRAND (ID, "NAME", CONTRY) VALUES (1, 'SIMENCE', 'DE');
insert INTO BRAND (ID, "NAME", CONTRY) VALUES (2, 'LADA', 'RU');
SELECT * FROM BRAND;

insert INTO PRODUCT (ID, "NAME", BRENDID) VALUES (0, 'T-SHIRT', 0);
insert INTO PRODUCT (ID, "NAME", BRENDID) VALUES (1, 'JEANS', 0);
insert INTO PRODUCT (ID, "NAME", BRENDID) VALUES (2, 'BOOTS', 0);
insert INTO PRODUCT (ID, "NAME", BRENDID) VALUES (3, 'BATARY', 1);
insert INTO PRODUCT (ID, "NAME", BRENDID) VALUES (4, 'MODUL', 1);
insert INTO PRODUCT (ID, "NAME", BRENDID) VALUES (5, 'AM', 2);
insert INTO PRODUCT (ID, "NAME", BRENDID) VALUES (6, '', 2);

SELECT * from PRODUCT;

INSERT INTO WAREHOUSE (ID, "NAME") VALUES (0, 'MOSCOW');
INSERT INTO WAREHOUSE (ID, "NAME") VALUES (1, 'SPB');
SELECT * FROM WAREHOUSE;

INSERT INTO GOODS (ID, WAREHOUSEID, PRODUCTID, QUANTITY) VALUES (0, 0, 0, 5);
INSERT INTO GOODS (ID, WAREHOUSEID, PRODUCTID, QUANTITY) VALUES (1, 1, 0, 2);
INSERT INTO GOODS (ID, WAREHOUSEID, PRODUCTID, QUANTITY) VALUES (2, 0, 1, 3);
INSERT INTO GOODS (ID, WAREHOUSEID, PRODUCTID, QUANTITY) VALUES (3, 1, 1, 7);
INSERT INTO GOODS (ID, WAREHOUSEID, PRODUCTID, QUANTITY) VALUES (4, 0, 3, 2);
INSERT INTO GOODS (ID, WAREHOUSEID, PRODUCTID, QUANTITY) VALUES (5, 1, 3, 8);
SELECT * FROM GOODS;
DELETE FROM GOODS ;


    SELECT product.ID, SUM(goods.QUANTITY) as sumOfQuantity, MAX (goods.QUANTITY) maxQuantity
    FROM BRAND brand 
        inner join PRODUCT product on brand.ID = product.BRENDID
        inner join GOODS goods on product.ID = goods.PRODUCTID
        inner join WAREHOUSE warehouse on goods.WAREHOUSEID = warehouse.ID
    GROUP BY product.ID HAVING SUM(goods.QUANTITY)>4;


SELECT product."NAME", SUM(goods.QUANTITY) as sumOfQuantity, MAX (goods.QUANTITY) maxQuantity
    FROM GOODS goods
        inner join PRODUCT product on goods.PRODUCTID = product.ID
GROUP BY product."NAME" HAVING SUM(goods.QUANTITY)>4;


SELECT goods.PRODUCTID, SUM(goods.QUANTITY) as sumOfQuantity
    FROM GOODS goods 
GROUP BY goods.PRODUCTID HAVING SUM(goods.QUANTITY)>4;

SELECT  product.NAME,
 (Select SUM(goods.QUANTITY) from goods where goods.PRODUCTID=product.id ) as mysum,
 (Select warehouse."NAME"  from WAREHOUSE warehouse 
    where warehouse.ID =
        (SELECT goods.WAREHOUSEID from GOODS goods 
            WHERE goods.PRODUCTID= product.ID 
            and goods.QUANTITY=
                (Select GROUP_CONCAT(g.QUANTITY order by g.QUANTITY desc) QUANTITY  
                from GOODS g
                where g.PRODUCTID=product.id 
                GROUP BY g.QUANTITY
                 )
            )
    )
    from PRODUCT product;
-----------------------------------
SELECT  product.NAME,
    (Select SUM(goods.QUANTITY) from GOODS goods where goods.PRODUCTID=product.id
        ) sumQuantity, warehouse."NAME", goods.QUANTITY
from PRODUCT product
    inner join GOODS goods on product.ID = goods.PRODUCTID
    inner join WAREHOUSE warehouse on goods.WAREHOUSEID = warehouse.ID 
    where
        (Select SUM(goods.QUANTITY) from GOODS goods where goods.PRODUCTID=product.id) >100
        AND goods.QUANTITY=(Select MAX(goods.QUANTITY) from GOODS goods where goods.PRODUCTID=product.id);

SELECT  product.NAME, warehouse."NAME", goods.QUANTITY
    from PRODUCT product
        inner join GOODS goods on product.ID = goods.PRODUCTID
        inner join WAREHOUSE warehouse on goods.WAREHOUSEID = warehouse.ID 
    where
        (Select SUM(goods.QUANTITY) from GOODS goods where goods.PRODUCTID=product.id) >100
        AND goods.QUANTITY=(Select MAX(goods.QUANTITY) from GOODS goods where goods.PRODUCTID=product.id);
