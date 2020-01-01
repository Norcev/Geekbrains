-- Первая версия

DROP DATABASE IF EXISTS geekbrains_hotel;

CREATE DATABASE geekbrains_hotel;
USE geekbrains_hotel;


CREATE TABLE hotel (
name VARCHAR(30) NOT NULL PRIMARY KEY,
street_number INT(10) NOT NULL,
street_name VARCHAR(50) NOT NULL,
city VARCHAR(30) NOT NULL,
zip_code VARCHAR(6) NOT NULL,
phone VARCHAR(100) NOT NULL UNIQUE,
manager_name VARCHAR(20) NOT NULL,
UNIQUE (street_number,street_name,city,zip_code)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE capacity (
hotel_id VARCHAR(30) NOT NULL,
`type` VARCHAR(10) NOT NULL,
`number` VARCHAR (10) NOT NULL,
PRIMARY KEY (hotel_id, `type`),
FOREIGN KEY (hotel_id) REFERENCES hotel(name) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE customer (
cust_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30) NOT NULL ,
`number` VARCHAR (10) NOT NULL,
street VARCHAR(50) NOT NULL,
city VARCHAR(30) NOT NULL,
zip_code VARCHAR (10) NOT NULL,
status VARCHAR(11) NOT NULL,
UNIQUE (`number`,street,city,zip_code)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE reservation(
hotel_name VARCHAR(30) NOT NULL,
cust_id INTEGER NOT NULL,
room_type VARCHAR(10) NOT NULL,
begin_date DATE NOT NULL,
end_date DATE NOT NULL,
credit_card_number VARCHAR(16) NOT NULL,
exp_date DATE NOT NULL,
PRIMARY KEY (hotel_name,cust_id,begin_date,end_date),
FOREIGN KEY (cust_id) REFERENCES customer(cust_id) ON DELETE NO ACTION,
FOREIGN KEY (hotel_name, room_type) REFERENCES capacity(hotel_id, `type`) ON DELETE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE occupancy(
hotel_name VARCHAR(30) NOT NULL,
room_type VARCHAR(10) NOT NULL,
`number` VARCHAR(10) NOT NULL,
PRIMARY KEY (hotel_name, room_type),
FOREIGN KEY (hotel_name, room_type) REFERENCES capacity(hotel_id, `type`) ON DELETE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE prefferdcustomer(
cust_id INT NOT NULL PRIMARY KEY ,
cust_name  VARCHAR(20) NOT NULL,
hotel_name VARCHAR(20) NOT NULL,
FOREIGN KEY (hotel_name) REFERENCES hotel (name) ON DELETE NO ACTION,
FOREIGN KEY (cust_id) REFERENCES customer (cust_id) ON DELETE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

###############
###FUNCTIONS###
###############

-- Проверка почтового индекса

DELIMITER $$
CREATE PROCEDURE proc_zip (IN zip_code VARCHAR(6), IN table_name VARCHAR(30))
BEGIN
declare MSG varchar(128);
IF NOT zip_code REGEXP '^[0-9]{6}$' THEN
SET MSG = concat('[table:', table_name, '] - zip is not valid, expected 6 digits: ', zip_code);
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
END IF;
END $$
DELIMITER ;


-- Проверка номера телефона отеля
DELIMITER $$
CREATE PROCEDURE proc_phone (IN phone_number VARCHAR(20), IN table_name VARCHAR(30))
BEGIN
declare MSG varchar(128);
IF NOT phone_number REGEXP '^[0-9]{10}$' THEN
SET MSG = concat('[Table:', table_name, '] - invalid phone number: ', phone_number);
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
END IF;
END $$
DELIMITER ;


-- Проверка  номера кредитной карты

DELIMITER $$
CREATE PROCEDURE credit_card (IN credit_number VARCHAR(20), IN table_name VARCHAR(30))
BEGIN
declare MSG varchar(128);
IF NOT credit_number REGEXP '^[0-9]{15,16}$' THEN
SET MSG = concat('[Table:', table_name, '] - invalid credit card number: ', credit_number);
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
END IF;
END $$
DELIMITER ;



-- Проверка даты кредитной карты

DELIMITER $$
CREATE PROCEDURE data_card (IN credit_card_data VARCHAR(20), IN table_name VARCHAR(30))
BEGIN
declare MSG varchar(128);
IF credit_card_data < NOW() THEN
-- DATE_FORMAT(credit_card_data,"%Y%m") < DATE_FORMAT(NOW(),"%Y%m")
SET MSG = concat('[Table:', table_name, '] - invalid date credit card : ', credit_card_data );
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
END IF;
END $$
DELIMITER ;


-- Проверка  статуса клиента

DELIMITER $$
CREATE PROCEDURE  status_client (IN status VARCHAR(15), IN table_name VARCHAR(30))
BEGIN
declare MSG varchar(128);
IF NOT status REGEXP '^(gold|silver|bisness)$' THEN
SET MSG = concat('[Table:', table_name, '] - invalid status client: ', status );
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
END IF;
END $$
DELIMITER ;


-- Проверка  даты резервации

DELIMITER $$
CREATE PROCEDURE  date_reservation (IN begin_date VARCHAR(15),IN end_date VARCHAR(15), IN table_name VARCHAR(30))
BEGIN
declare MSG varchar(128);
-- IF  begin_date >= end_date THEN
If DATE_FORMAT(begin_date,"%Y%m%d") > DATE_FORMAT(end_date,"%Y%m%d") THEN
SET MSG = concat('[Table:', table_name, '] - invalid date reservation : ', end_date,' before ',begin_date);
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
END IF;
END $$
DELIMITER ;



-- Проверить на свободные бронирования при вставке в таблицу занятости 

DELIMITER $$
CREATE PROCEDURE  proc_check_occupancy (IN `hotel-name` VARCHAR(20),IN `room-type` VARCHAR(8),
																		IN `end-date` DATE, IN `begin_date` DATE)
BEGIN
declare MSG varchar(128);
declare occupancy_now INT (10);
declare capacity INT (10);
declare occupancy_total INT (10);

SET  occupancy_now = (SELECT IFNULL (SUM(DATEDIFF (end_date,begin_date)),0) FROM  reservation 
WHERE hotel_name = `hotel-name` and room_type = `room-type`);

SET capacity  = (SELECT number
FROM capacity
WHERE hotel_id = `hotel-name` and `type` = `room-type`);

SET occupancy_total  = (occupancy_now + DATEDIFF (date_end,date_begin));

IF occupancy_total > capacity THEN
 SET MSG = CONCAT('Maximum capacity reached hotel',hotel);
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
ELSE
	REPLACE INTO occupancy VALUES (`hotel-name`,`room-type`,occupancy_total);
END IF;
END $$
DELIMITER ;


##############
###TRIGGERS###
##############

-- HOTEL table

DELIMITER $$
CREATE TRIGGER hotel_insert BEFORE INSERT ON hotel
FOR EACH ROW
BEGIN
CALL proc_zip(NEW.zip_code,'hotel');
CALL proc_phone(NEW.phone, 'hotel');
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER hotel_update BEFORE UPDATE ON hotel
FOR EACH ROW
BEGIN
CALL proc_zip(NEW.zip_code,'hotel');
CALL proc_phone(NEW.phone, 'hotel');
END$$
DELIMITER ;



-- reservation table
DELIMITER $$
CREATE TRIGGER reservation_insert BEFORE INSERT ON reservation
FOR EACH ROW
BEGIN
CALL credit_card(NEW.credit_card_number, 'reservation');
CALL data_card(NEW.exp_date, 'reservation');
CALL date_reservation(NEW.begin_date, NEW.end_date, 'reservation');
CALL proc_check_occupancy(NEW.hotel_name, NEW.room_type, NEW.begin_date, NEW.end_date);
END$$
DELIMITER ; 



DELIMITER $$
CREATE TRIGGER reservation_update BEFORE UPDATE ON reservation
FOR EACH ROW
BEGIN
CALL credit_card(NEW.credit_card_number, 'reservation');
CALL data_card(NEW.exp_date, 'reservation');
END$$
DELIMITER ;



-- customer  table

DELIMITER $$
CREATE TRIGGER customer_insert BEFORE INSERT ON customer
FOR EACH ROW
BEGIN
CALL status_client(NEW.status, 'customer');
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER customer_update BEFORE UPDATE ON customer
FOR EACH ROW
BEGIN
CALL status_client(NEW.status, 'customer');
END$$
DELIMITER ;

INSERT INTO `hotel` VALUES ('Berge-Maggio','74','Diana Corner','New Shaina','214365','8197954135','Langworth'),
('Braun Group','71','Krista Flats','Dietrichborough','476366','9534216585','Williamson'),
('Collins, Cremin and Medhurst','73','Julius Prairie','New Camdenborough','232917','5148756003','Morar'),
('Gaylord Inc','186','Kunde Camp','West Marleeburgh','172575','6628590669','Hansen'),
('Lockman, Ortiz and Bins','182','Klocko Square','Lake Ian','784326','1322477215','Braun'),
('Mante, Daniel and Williamson','245','Morar Wall','Lake Brycenmouth','150283','2692753113','Mraz'),
('O\'Hara LLC','82','Hackett Well','New Caesar','325231','3565354463','Tromp'),
('Schamberger, Wintheiser and Je','227','Candida Cliff','East Ali','976117','2535966800','Trantow'),
('Schmeler-Gaylord','48','Loraine Extension','East Alexandroshire','942402','3341464040','Boyer'),
('Walker-Metz','35','Kaitlyn Lock','Katrineton','779669','6957158351','Koch'); 


INSERT INTO `capacity` VALUES ('Berge-Maggio','Обычный','117'),
('Berge-Maggio','Семейный','53'),
('Braun Group','Бизнес','110'),
('Braun Group','Люкс','225'),
('Braun Group','Семейный','186'),
('Collins, Cremin and Medhurst','Бизнес','217'),
('Collins, Cremin and Medhurst','Люкс','276'),
('Collins, Cremin and Medhurst','Семейный','204'),
('Gaylord Inc','Люкс','81'),
('Gaylord Inc','Обычный','17'),
('Gaylord Inc','Семейный','119'),
('Lockman, Ortiz and Bins','Бизнес','98'),
('Lockman, Ortiz and Bins','Обычный','114'),
('Lockman, Ortiz and Bins','Семейный','81'),
('Mante, Daniel and Williamson','Бизнес','59'),
('Mante, Daniel and Williamson','Люкс','93'),
('Mante, Daniel and Williamson','Обычный','211'),
('Mante, Daniel and Williamson','Семейный','171'),
('O\'Hara LLC','Бизнес','283'),
('O\'Hara LLC','Люкс','274'),
('O\'Hara LLC','Обычный','79'),
('O\'Hara LLC','Семейный','83'),
('Schamberger, Wintheiser and Je','Бизнес','147'),
('Schamberger, Wintheiser and Je','Люкс','129'),
('Schamberger, Wintheiser and Je','Семейный','155'),
('Schmeler-Gaylord','Бизнес','264'),
('Schmeler-Gaylord','Обычный','281'),
('Schmeler-Gaylord','Семейный','197'),
('Walker-Metz','Бизнес','164'),
('Walker-Metz','Обычный','109'),
('Walker-Metz','Семейный','266'); 


INSERT INTO `customer` VALUES ('1','Alexandrea Rohan I','143','Sauer Glens','Donniehaven','730598','bisness'),
('2','Lina Upton','292','Kautzer Point','East Einarville','771185','silver'),
('3','Thalia Schuster','135','Gideon Drive','New Pedro','356731','silver'),
('4','Roslyn Beatty','268','Quitzon Trafficway','Adamsview','930011','silver'),
('5','Dr. Avery Kovacek DVM','237','Hegmann Radial','North Sebastianhaven','468697','silver'),
('6','Gregg Herzog','52','Ryley Isle','Skilesview','542301','gold'),
('7','Nona Hahn','129','Walker Causeway','Handchester','357798','silver'),
('8','Emmy Kris','298','Marcos Groves','Littelberg','416355','gold'),
('9','Sister Collier','21','Helena Causeway','Jadonview','138931','silver'),
('10','Emmanuel Okuneva','289','Rosenbaum Trafficway','Francobury','996718','bisness'),
('11','Judd Borer','168','Rolfson Light','West Eulaliamouth','195098','bisness'),
('12','Dashawn Kihn','114','Strosin Valleys','Port Flavieville','670818','silver'),
('13','Talia Batz','89','Chelsie Branch','Rhiannonburgh','219050','bisness'),
('14','Tommie Champlin','283','Mayert Circles','Amayafurt','387265','gold'),
('15','Miss Adela Carter II','80','Turner Stravenue','South Jordane','752902','silver'),
('16','William Boyle','188','Ivah Branch','New Sandy','331514','silver'),
('17','Kory Miller','166','Daugherty Fords','Davontemouth','854471','silver'),
('18','Mrs. Elna Carroll','262','Cordia Mews','Patienceside','717846','silver'),
('19','Erik Koch','155','Rolfson Summit','North Magdalenhaven','298558','gold'),
('20','Mae Deckow','32','Wiegand Mountain','Lake Rahulborough','365086','gold'),
('21','Marjorie Wisozk','58','Wilfrid Junctions','Foreststad','912588','gold'),
('22','Myrl Yost','145','Gibson Unions','North Arielle','949658','bisness'),
('23','Dr. Erich Hilll III','49','Boyer Shores','East Lorimouth','232268','silver'),
('24','Kyleigh Skiles','40','Hoeger Rapid','Karlieborough','628219','silver'),
('25','Kimberly Durgan','295','Wyman Pines','Shaniyaberg','609057','bisness'),
('26','Ms. Casandra Barton DVM','284','Maggio Trafficway','Kassandraville','835706','bisness'),
('27','Marguerite Weimann','45','Hoppe Dale','East Amina','978480','bisness'),
('28','Ariel Frami','184','Orn Ranch','Coleshire','330581','bisness'),
('29','Mrs. Eleanore Gibson','157','Emmet Expressway','Shanahanton','756875','silver'),
('30','Miss Darby Watsica III','229','Renner Freeway','Gutmannbury','250725','gold'),
('31','Bud Nolan','2','Gunnar Vista','Lake Josiefurt','229767','gold'),
('32','Gerda Lesch','119','Ondricka Villages','Linwoodhaven','548724','gold'),
('33','Prof. Granville Smitham III','175','Ratke Islands','Port Ovachester','679026','gold'),
('34','Katrine Wolff','25','Marlon Lakes','Kuhlmanfort','260467','gold'),
('35','Jamey Stehr','135','Schmidt Land','New Denis','796268','gold'),
('36','Charlotte Morar','14','Amiya Run','East Marielastad','938119','bisness'),
('37','Blaise DuBuque I','232','Pacocha Courts','South Leonor','473544','bisness'),
('38','Dr. Larry Parker','41','Rolfson Skyway','Lexieview','979907','gold'),
('39','Alda Kunze','180','Graham Dam','Layneland','526647','silver'),
('40','Rozella Baumbach','165','Zemlak Neck','South Kevinside','640058','gold'),
('41','Hoyt Bogisich','51','Lakin Curve','Bergehaven','524067','gold'),
('42','Maurine Senger','9','Weimann Branch','Vandervortton','622077','gold'),
('43','Domingo Abbott DVM','157','Breitenberg Junctions','Boscochester','626080','gold'),
('44','Prof. Jazmyne Wisozk','28','Warren Bridge','Hellershire','689072','silver'),
('45','Ms. Emma Quigley V','283','Annamae Crossing','East Antoinette','972094','gold'),
('46','Nikko Schultz','76','Rossie Road','Trompfurt','125292','gold'),
('47','Katarina Frami','111','Fritsch Villages','New Jaunita','241155','gold'),
('48','Roderick Zieme','44','Fisher Point','Port Novella','612750','bisness'),
('49','Dr. Elbert Spencer','15','Turcotte Key','Lake Loyceside','648167','bisness'),
('50','Dimitri Howell','68','Frankie Mission','Faeborough','204531','gold'),
('51','Lyda Hills PhD','91','Pinkie Village','Franeckiside','639091','gold'),
('52','Julius Jacobs','215','Gislason Street','Faheyberg','246243','gold'),
('53','Yasmine Beer','32','Luettgen Roads','East Jaleelfurt','428541','gold'),
('54','Miss Macy Rowe IV','145','Moen Harbor','Wilkinsonshire','855091','silver'),
('55','Mr. Javon Heaney PhD','254','Piper Light','Vivianfurt','583415','bisness'),
('56','Fred Reynolds II','229','Rachel Prairie','South Niamouth','482928','bisness'),
('57','Alvina Medhurst IV','154','Lucy Circle','Wymanville','845765','gold'),
('58','Annabel Stoltenberg','250','Bradly Streets','Forestfort','389568','bisness'),
('59','Miss Flo Abshire','164','Kenyatta Summit','Ornville','399128','silver'),
('60','Zackary Boyer','242','Verda Summit','South Rainahaven','765299','bisness'),
('61','Modesto Heathcote V','102','Kertzmann Roads','Abbottbury','770386','bisness'),
('62','Hosea Watsica','246','Williamson Isle','Port Phoebe','232591','silver'),
('63','Neil Feil','73','Douglas Union','South Katrinaberg','962278','bisness'),
('64','Katrine Heller','233','Funk Isle','Port Heathburgh','582557','bisness'),
('65','Carlo Abernathy III','25','Dooley Green','Lake Vaughn','402837','silver'),
('66','Yolanda Wunsch','87','Rippin Stravenue','Norristown','147859','gold'),
('67','Laverna Hoeger','181','Marquardt Keys','Feeneyfurt','809503','silver'),
('68','Caden Ernser','133','Nader Centers','Schambergerland','822437','bisness'),
('69','Kassandra Johns','183','Jeremie Forks','South Kacey','490432','bisness'),
('70','Casper Fahey','259','Anastacio Trace','Keatontown','961113','silver'),
('71','Lawson Smitham','201','George Vista','Maddisonton','589196','gold'),
('72','Citlalli Hyatt','284','Mikel Shore','Port Wendy','464184','bisness'),
('73','Mrs. Minnie Hickle','62','Grant Harbors','Lake Adahberg','430453','bisness'),
('74','Antonio Parisian Sr.','113','Luciano Fort','Filomenastad','650021','bisness'),
('75','Precious Bruen','198','Clint Via','New Adelia','795805','bisness'),
('76','Garnett Luettgen','298','Gottlieb Forges','Vandervorthaven','641198','bisness'),
('77','Clare Cartwright','54','Rolando Track','West Edgar','230072','silver'),
('78','Mrs. Amely Larkin IV','50','Jennyfer Park','Amandafurt','764636','silver'),
('79','Dr. Jeffrey Lind','117','Frami Cliffs','Bauchview','494429','bisness'),
('80','Timothy Hand','146','VonRueden Crest','Ignatiusstad','570440','bisness'),
('81','Dr. Rickey Bogan','239','Franecki Street','New Joyceville','976902','bisness'),
('82','Miss Laurence Rohan II','175','Clarissa Stream','Lake Beulahstad','720433','silver'),
('83','Mrs. Katarina Schultz','227','Adell Ford','East Weldon','221644','gold'),
('84','Mrs. Peggie Mitchell','187','Bosco Vista','Port Katherine','541301','bisness'),
('85','Maudie Nienow','11','Bergstrom Ports','Lake Darienchester','287634','bisness'),
('86','Judy Daniel','272','Terry Loaf','Elisaport','438535','bisness'),
('87','Miss Chyna Pacocha III','202','Allen Valley','Watersmouth','257821','bisness'),
('88','Mrs. Tomasa Predovic PhD','271','Von Gardens','New Ellie','661875','gold'),
('89','Shad Mertz','204','Fadel Bypass','Stehrview','819815','bisness'),
('90','Ms. Telly Kuvalis DDS','142','Stanton Highway','Port Luciousville','582311','gold'),
('91','Mr. Macey Stamm Jr.','277','Yost Square','New Winstonville','614185','silver'),
('92','Sarah Littel','64','Rath Manor','South Ransom','190129','bisness'),
('93','Prof. Mikel Bauch II','300','Klein Crest','West Saigeside','775158','bisness'),
('94','Darron Grant','216','Schmitt Crescent','Gibsonstad','403492','gold'),
('95','Prof. Gussie Dicki PhD','45','Bergstrom Ramp','Schultzview','450551','silver'),
('96','Ms. Betty Barton','38','Anahi Port','Port Hilma','113105','silver'),
('97','Renee Okuneva','91','Larue Ridge','Edwardland','734616','bisness'),
('98','Theron Breitenberg','284','Schroeder Mountain','North Dameonville','894542','gold'),
('99','Morris Windler','274','Hessel Stravenue','Drewhaven','921783','gold'),
('100','Marley Quigley','10','Webster Fork','Lake Hortense','908851','silver'); 





INSERT INTO `reservation` VALUES ('Braun Group','3','Бизнес','2019-12-17','2019-12-18','3766623458234005','2020-12-31'),
('Braun Group','4','Бизнес','2019-12-17','2019-12-19','5410581697493604','2020-12-31'),
('Braun Group','5','Бизнес','2019-12-17','2019-12-20','4916850220742123','2020-12-31'),
('Collins, Cremin and Medhurst','6','Бизнес','2019-12-17','2019-12-21','4716959997234659','2020-12-31'),
('Collins, Cremin and Medhurst','7','Бизнес','2019-12-17','2019-12-21','4716153735581993','2020-12-31'),
('Collins, Cremin and Medhurst','8','Бизнес','2019-12-17','2019-12-23','5387914256629273','2020-12-31'),
('Gaylord Inc','9','Люкс','2019-12-17','2019-12-23','4916754951794174','2020-12-31'),
('Gaylord Inc','10','Люкс','2019-12-17','2019-12-25','5513082481402962','2020-12-31'),
('Gaylord Inc','11','Люкс','2019-12-17','2019-12-26','3445526015719344','2020-12-31'),
('Mante, Daniel and Williamson','15','Обычный','2019-12-17','2019-12-27','4916619430723432','2020-12-31'),
('Mante, Daniel and Williamson','16','Обычный','2019-12-17','2019-12-28','3782463247496563','2020-12-31'),
('Mante, Daniel and Williamson','17','Обычный','2019-12-17','2019-12-29','5165746932498421','2020-12-31'),
('Mante, Daniel and Williamson','18','Обычный','2019-12-17','2019-12-30','4716547225310111','2020-12-31'),
('O\'Hara LLC','19','Обычный','2019-12-17','2020-01-01','5580872646550169','2020-12-31'),
('O\'Hara LLC','20','Обычный','2019-12-17','2020-01-02','4418746811546456','2020-12-31'),
('O\'Hara LLC','21','Обычный','2019-12-17','2020-01-03','5348850892076321','2020-12-31'),
('O\'Hara LLC','22','Семейный','2019-12-17','2020-01-04','5272148365227951','2020-12-31'),
('Schamberger, Wintheiser and Je','23','Семейный','2019-12-17','2020-01-05','5271648985081935','2020-12-31'),
('Schamberger, Wintheiser and Je','24','Семейный','2019-12-17','2020-01-06','3471811997034716','2020-12-31'),
('Schamberger, Wintheiser and Je','25','Семейный','2019-12-17','2020-01-08','3467668614532840','2020-12-31'),
('Schmeler-Gaylord','26','Семейный','2019-12-17','2020-01-09','4539504219689488','2020-12-31'),
('Schmeler-Gaylord','27','Семейный','2019-12-17','2020-01-10','4024007147285868','2020-12-31'),
('Schmeler-Gaylord','28','Семейный','2019-12-17','2020-01-11','5419541042186476','2020-12-31'),
('Walker-Metz','29','Семейный','2019-12-17','2020-01-12','5246063565722554','2020-12-31'),
('Walker-Metz','30','Семейный','2019-12-17','2020-01-13','4599765614787120','2020-12-31'); 



