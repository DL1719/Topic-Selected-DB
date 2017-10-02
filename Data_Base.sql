SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema corrupcion
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `corrupcion` ;

-- -----------------------------------------------------
-- Schema corrupcion
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `corrupcion` DEFAULT CHARACTER SET utf8 ;
USE `corrupcion` ;

-- -----------------------------------------------------
-- Table `corrupcion`.`Periodico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `corrupcion`.`Periodico` (
  `NombrePeriodico` VARCHAR(45) NOT NULL,
  `CallePeriodico` VARCHAR(45) NOT NULL,
  `NumeroPeriodico` VARCHAR(10) NOT NULL,
  `ColoniaPeriodico` VARCHAR(45) NOT NULL,
  `MunicipioPeriodico` VARCHAR(45) NOT NULL,
  `EstadoPeriodico` VARCHAR(45) NOT NULL,
  `PaisPeriodico` VARCHAR(45) NOT NULL,
  `Tiraje` INT(9) NOT NULL,
  PRIMARY KEY (`NombrePeriodico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `corrupcion`.`Caso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `corrupcion`.`Caso` (
  `idCaso` VARCHAR(20) NOT NULL,
  `NombreCaso` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Desvio` DECIMAL(12,2) NOT NULL,
  `PaisOrigen` VARCHAR(45) NOT NULL,
  `idPeriodico` VARCHAR(45) NOT NULL,
  `FechaDescubrimiento` DATE NOT NULL,
  `Dictamen` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idCaso`),
  INDEX `fk_idPeriodico_idx` (`idPeriodico` ASC),
  CONSTRAINT `fk_idPeriodico`
    FOREIGN KEY (`idPeriodico`)
    REFERENCES `corrupcion`.`Periodico` (`NombrePeriodico`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `corrupcion`.`Ciudadano`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `corrupcion`.`Ciudadano` (
  `idCiudadano` VARCHAR(20) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `ApellidoPaterno` VARCHAR(45) NOT NULL,
  `ApellidoMaterno` VARCHAR(45) NOT NULL,
  `FechaNacimiento` DATE NOT NULL,
  `Calle` VARCHAR(45) NOT NULL,
  `Numero` VARCHAR(5) NOT NULL,
  `Colonia` VARCHAR(45) NOT NULL,
  `Municipio` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Pais` VARCHAR(45) NOT NULL,
  `Patrimonio` DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (`idCiudadano`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `corrupcion`.`Juez`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `corrupcion`.`Juez` (
  `idJuez` VARCHAR(20) NOT NULL,
  `FechaComienzo` DATE NOT NULL,
  PRIMARY KEY (`idJuez`),
  CONSTRAINT `fk_ciudadano`
    FOREIGN KEY (`idJuez`)
    REFERENCES `corrupcion`.`Ciudadano` (`idCiudadano`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `corrupcion`.`Partido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `corrupcion`.`Partido` (
  `NombrePartido` VARCHAR(45) NOT NULL,
  `CallePartido` VARCHAR(45) NOT NULL,
  `NumeroPartido` VARCHAR(5) NOT NULL,
  `ColoniaPartido` VARCHAR(45) NOT NULL,
  `MunicipioPartido` VARCHAR(45) NOT NULL,
  `EstadoPartido` VARCHAR(45) NOT NULL,
  `PaisPartido` VARCHAR(45) NOT NULL,
  `TelefonoPartido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NombrePartido`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `corrupcion`.`CasoCiudadano`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `corrupcion`.`CasoCiudadano` (
  `idCaso` VARCHAR(20) NOT NULL,
  `idCiudadano` VARCHAR(20) NOT NULL,
  `Cargo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idCaso`, `idCiudadano`),
  INDEX `fk_ciudcaso_idx` (`idCiudadano` ASC),
  CONSTRAINT `fk_casociu`
    FOREIGN KEY (`idCaso`)
    REFERENCES `corrupcion`.`Caso` (`idCaso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ciudcaso`
    FOREIGN KEY (`idCiudadano`)
    REFERENCES `corrupcion`.`Ciudadano` (`idCiudadano`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `corrupcion`.`PartidoCiudadano`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `corrupcion`.`PartidoCiudadano` (
  `NombrePartido` VARCHAR(45) NOT NULL,
  `idCiudadano` VARCHAR(20) NOT NULL,
  `Puesto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NombrePartido`, `idCiudadano`),
  INDEX `fk_ciudadnopar_idx` (`idCiudadano` ASC),
  CONSTRAINT `fk_partidociu`
    FOREIGN KEY (`NombrePartido`)
    REFERENCES `corrupcion`.`Partido` (`NombrePartido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ciudadnopar`
    FOREIGN KEY (`idCiudadano`)
    REFERENCES `corrupcion`.`Ciudadano` (`idCiudadano`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `corrupcion`.`PartidoPeriodico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `corrupcion`.`PartidoPeriodico` (
  `NombrePartido` VARCHAR(45) NOT NULL,
  `NombrePeriodico` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NombrePartido`, `NombrePeriodico`),
  INDEX `fk_periodicopar_idx` (`NombrePeriodico` ASC),
  CONSTRAINT `fk_partidoper`
    FOREIGN KEY (`NombrePartido`)
    REFERENCES `corrupcion`.`Partido` (`NombrePartido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_periodicopar`
    FOREIGN KEY (`NombrePeriodico`)
    REFERENCES `corrupcion`.`Periodico` (`NombrePeriodico`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `corrupcion`.`CasoJuez`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `corrupcion`.`CasoJuez` (
  `idCaso` VARCHAR(20) NOT NULL,
  `idJuez` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idCaso`, `idJuez`),
  INDEX `fk_juez_idx` (`idJuez` ASC),
  CONSTRAINT `fk_caso`
    FOREIGN KEY (`idCaso`)
    REFERENCES `corrupcion`.`Caso` (`idCaso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_juez`
    FOREIGN KEY (`idJuez`)
    REFERENCES `corrupcion`.`Juez` (`idJuez`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO CIUDADANO 
VALUES ('52710695', 'Adriana Paola', 'Cujar', 'Alarcon', '1994-12-14', 'Bedfordshire', 123, "Aagaard Islands", 'NYC', 'NY', 'Brasil', 287100);
INSERT INTO CIUDADANO
VALUES ('51738984', 'Adriana', 'Giraldo', 'Gomez', '1980-12-16', 'Berkshire', 145, "Abraxas Lake", 'Reims', 'NY', 'EE.UU.', 276500.90);
INSERT INTO CIUDADANO
VALUES ('52355290' , "Adriana Marcela", 'Salcedo', 'Segura', '1994-12-29', 'Buckinghamshire', 122, "Ace Lake", 'Paris', 'CA', 'Brasil', 388400.34);
INSERT INTO CIUDADANO
VALUES ('79962291' , 'Alexander', 'Duarte', 'Sandoval', '1984-12-28', 'Cambridgeshire', 190, "Adams Fjord", 'Pasadena', 'NY', 'EE.UU.', 374600.70);
INSERT INTO CIUDADANO
VALUES ('41547273' , 'Alcira', 'Santanilla', 'Carvajal', '1974-12-26', 'Cheshire', 330, "Adams Glacier", 'Pasadena', 'CA', 'Brasil',5205000.27);
INSERT INTO CIUDADANO
VALUES ('51899077' , 'Amparo', 'Montoya', 'Montoya', '1990-12-15', 'Cornwall', 090, "Adamson Bay", "San Francisco", 'NY', 'EE.UU.', 3479000.76);
INSERT INTO CIUDADANO
VALUES('39568175' , "Ana Maria", 'Lozano', 'Santos', '1975-12-29', 'Cumbria', 349, "Adamson Spur", 'Burlingame', 'CA', 'Brasil', 2497000.77);
INSERT INTO CIUDADANO
VALUES('52755672' , 'Andrea', 'Ariza', 'Zambrano', '1977-12-18', 'Chubu', 456, "Ainsworth Bay", 'Lille', 'NY', 'EE.UU.', 5510002.32);
INSERT INTO CIUDADANO
VALUES('52817196' , "Andrea Carolina", 'Acuña', 'Mendoza', '1994-12-17', 'Chugoku', 567, "Aker Peaks", 'Bergen', 'Victoria', 'Brasil',216800.54);
INSERT INTO CIUDADANO
VALUES('52960227' , "Andrea Del Pilar", 'Cortes', 'Barreto', '1989-12-22', 'Hokkaido', 234, "Albino Rookery", "San Francisco", 'NY', 'EE.UU.', 470800.44);
INSERT INTO CIUDADANO
VALUES('52329187' , "Andrea Del Pilar", 'Guzman', 'Rojas', '1989-2-1' , 'Kansai', 124, "Alexander Nunataks", 'Paris', 'Victoria', 'Brasil',396005.66);
INSERT INTO CIUDADANO
VALUES('52494004' , "Andrea Paola", 'Gutierrez', 'Romero', '1978-1-22', 'Kanto', 094, "Alga Lake", 'Melbourne', 'NY', 'EE.UU.',2333000.12);
INSERT INTO CIUDADANO
VALUES('52705875' , "Andrea Liliana", 'Samper', 'Martinez', '1970-1-29', 'Kyushu', 984, "Allan Hills", 'NYC', 'NY', 'Brasil',3188000.64);
INSERT INTO CIUDADANO
VALUES('52987453' , "Andrea Marcela", 'Barragan', 'Garcia', '1981-1-21', 'Shikoku', 0945, "Alligator Island", 'Newark', 'CT', 'EE.UU.', 367600.70);
INSERT INTO CIUDADANO
VALUES('52880406' , "Andrea Yohanna", 'Pinzon', 'Yepes', '1982-1-14', "Bay Minette", 349, "Allison Dome", 'Bridgewater', 'NY', 'España', 4177000.35);
INSERT INTO CIUDADANO
VALUES('39559801' , 'Amelia', 'Perez', 'Tabares', '1984-1-21', "Bay Minette", 232, "Allison Ridge", 'Nantes', 'MA', 'EE.UU.', 4177000.35);
INSERT INTO CIUDADANO
VALUES('52453801' , "Alejandra Maria", 'Agudelo', 'Suarez', '1984-1-25', "Bay Minette", 394, "Amanda Bay", 'Cambridge', 'NY', 'España', 4099000.68);
INSERT INTO CIUDADANO
VALUES('19442527' , 'Alvaro', 'Calderon', 'Artunduaga', '1985-1-5', "Bon Secour", 949, "Amanda Rookery", 'Helsinki', 'PA', 'Japon', 4099000.68);
INSERT INTO CIUDADANO
VALUES('52198296' , "Ayda Catalina", 'Pulido', 'Chaparro', '1985-1-23', 'Daphne', 0954, "Amery Depression", 'Stavern', 'PA', 'España', 2597000.39);
INSERT INTO CIUDADANO
VALUES('52807753' , "Bertha Ximena Patricia", 'Barbosa', 'Torres', '1986-1-26', 'Elberta', 1245, "Amery Peaks", 'Allentown', 'NY', 'Japon', 2597000.39);
INSERT INTO CIUDADANO
VALUES('51650895' , 'Betsabe', 'Bautista', 'Vargas', '1986-1-9', 'Fairhope', 0945, "ANARE Nunataks", 'NYC', 'PA', 'España', 4394000.38);
INSERT INTO CIUDADANO
VALUES('80235960' , "Camilo Alexander", 'Bolivar', 'Forero', '1984-1-4', 'Foley', 34554, "Anchorage Island", 'Salzburg', 'NSW', 'Japon', 4390004.38);
INSERT INTO CIUDADANO
VALUES('30396689' , 'Carolina', 'Isaza', 'Ramirez', '1994-1-26', "Gulf Shores", 99, "Anchorage Patch", 'Chatswood', 'PA', 'España', 435800.04);
INSERT INTO CIUDADANO
VALUES('79998342' , "Cesar Augusto", 'Ramirez', 'Laverde', '1974-1-14', "Casimiro de Abreu", 69, "Anderson Lake", ' Nantes', 'MA', 'Japon', 435800.04);
INSERT INTO CIUDADANO
VALUES('52265956' , "Celmira Patricia", 'Arroyave', 'Corredor', '1974-1-14', "Silva Jardim", 2321, "Anniversary Nunataks", "New Bedford", 'PA', 'Mexico', 4300096.14);
INSERT INTO CIUDADANO
VALUES('52428220' , "Claudia Marcela", 'Navarrete', 'Cortes', '1975-12-27', 'Petrópolis', 09345, "Anton Island", 'Liverpool', 'PA', 'Japon', 4300096.14);
INSERT INTO CIUDADANO
VALUES('52962491' , "Claudia Marcela", 'Lozada', 'Aragon', '1970-12-26', "São José do Vale do Rio Preto", 34, "Anxiety Nunataks", 'Madrid', 'CA', 'Mexico', 773007.93);
INSERT INTO CIUDADANO
VALUES('52517450' , "Claudia Patricia", 'Bolivar', 'Carreño', '1988-11-21', 'Teresópolis', 345, "Allison Dome", 'Stavern', 'PA', 'Japon', 773007.93);
INSERT INTO CIUDADANO
VALUES('52427093' , "Claudia Patricia", 'Gallo', 'Cifuentes', '1988-12-14', "Buena Suerte", 9686, "Allison Dome", 'Lule', 'CT', 'Mexico', 145001);
INSERT INTO CIUDADANO
VALUES('39625110' , "Claudia Pilar", 'Vanegas', 'Ortiz', '1974-3-6', 'Porvenir', 234, "Allison Dome", 'Madrid', 'Tokio', 'Japon', 1451000);
INSERT INTO CIUDADANO VALUES(47009479092929, 'Elijah J', 'Aspe', 'Rotella', '1961-06-7', 'Gomez Rico',351 , 'Providencia', 'Mancha', 'Holguin', 'Cuba',8971230 );
INSERT INTO CIUDADANO VALUES(5681472192101257 , 'Winston U', 'Kenedy', 'Willsey', '1989-02-20', 'Little',106 , 'Coplin', 'Maple', 'Manitoba', 'Canada',3457800 );
INSERT INTO CIUDADANO VALUES(4834989387516220, 'Ivan', 'Aniston', 'Sutterfield', '1988-08-9', 'Wines Park', 564, 'Painter', 'Logba', 'Nunavut', 'Canada',645549 );
INSERT INTO CIUDADANO VALUES(378370640277449, 'Keith', 'George', 'Gaddis', '1977-04-6', 'Prospect', 722, 'Court', 'Dome', 'Queensland', 'Australia',2446444 );
INSERT INTO CIUDADANO VALUES(5491037336042913, 'Cesar', 'Saeteros', 'Vicuña', '1990-02-21', 'Gojenola', 2, 'Cortez', 'Monte', 'El Progreso', 'Guatemala', 6337923);
INSERT INTO CIUDADANO VALUES(5810664534763737 , 'Tobias', 'Galdran', 'Tanarro', '1969-09-15', 'Bulevar',830 , 'Orvay', 'Canto', 'San Andres', 'Colombia', 4554736);
INSERT INTO CIUDADANO VALUES(376457205561523, 'Ariel F.', 'Fernandez', 'Marcote', '1972-06-21', 'Real',892 , 'San Jose', 'Oca', 'Caqueta', 'Colombia', 5002256);
INSERT INTO CIUDADANO VALUES(374428052262723, 'Purificación', 'Benabdailah', 'Merino', '1990-02-21', 'Astrofisico', 232, 'Region Autonoma', 'Atlantico', 'Manabi', 'Ecuador', 2550274);
INSERT INTO CIUDADANO VALUES(348343104528042, 'Hermosa', 'Clorinda', 'Lema', '1986-05-9', 'Bulevar',739 , 'Albañi', 'Conga', 'Atacama', 'Cile',5001408 );
INSERT INTO CIUDADANO VALUES(379650194758822, 'Irene', 'Fornica', 'Eastwood', '1996-05-6', 'Fidler', 805, 'Circle', 'North Carolina', 'Iowa', 'EE.UU',7991280 );
INSERT INTO CIUDADANO VALUES(377386494864984, 'Emi', 'Karl', 'Faris', '1972-05-25', 'Chatham', 200, 'Hollow', 'Montreal', 'Nebraska', 'EE.UU',8994892 );
INSERT INTO CIUDADANO VALUES(378337723098638, 'Karen', 'Mentrog', 'Hoffer', '1995-05-15', 'Corpening', 398, 'Avenu', 'Klingstor', 'Schleswig-Holstein', 'Alemania', 227365);
INSERT INTO CIUDADANO VALUES(123443556456565, 'Martin', 'Laguna', 'Castro', '1994-02-19', ' Av.Libertador',498,'Norte 13', 'Florida' , 'Buenos Aires', 'Argentina', 3342100);
INSERT INTO CIUDADANO VALUES(091273458569483, 'Paola','Trinidad','Cosme','1991-09-18',"San Toribio",173,'Norte 12', 'Real','Lima','Peru',232343);
INSERT INTO CIUDADANO VALUES(834023847234945, 'Rodrigo','Santiago','Gonzalez','1994-12-14','Agustin Lara',234,'Sta Cecilia','Tlahuac','CDMX','Mexico',421340);
INSERT INTO CIUDADANO VALUES(234232445435654, 'Ernesto', 'Henrnandez', 'Bernal','1994-04-20','Apoquindo',3885,'La Condes','Lo Prado', 'Santiago','Chile',123439);
INSERT INTO CIUDADANO VALUES(423435443556563, 'Yazmin', ' Guerrero','Zuñiga','1995-06-07','Torre',777,'Caldas','Amazonas','Bogota','Colombia',212321);
INSERT INTO CIUDADANO VALUES(345567678684234, 'Carl','Schmidt','Weber','1994-04-26','Korn Ferry',26,'Hay Group','Nue Og','Berlin','Alemania',3234454);
INSERT INTO CIUDADANO VALUES(233445564590785, 'Alejandro','Cadena','Sandoval','1991-05-06','Ibarra',345,'Zaragoza','Galicia','Madrid','España',233242);

INSERT INTO CIUDADANO VALUES(4957700851727784 , 'Miriam','Paz','Mote','1980-09-11','Avenida Cabus',490,'Conservadores','Aguascalients','Aguascalientes','Mexico',18880770);
INSERT INTO CIUDADANO VALUES(4485025588105554, 'Simon','Budo','Martinez','1993-04-02','Bulevar Susi',746,'Fotografos','Santa Catarina','Nuevo Leon','Mexico',8545523);
INSERT INTO CIUDADANO VALUES(377342414869124, 'Cain','Rayego','Gonzalez','1968-10-28','Soberana',640,'Arboledas','Reynosa','Tamaulipas','Mexico',1442110);
INSERT INTO CIUDADANO VALUES(5797822260675635 , 'Nathan','Lemi','Piazza','1997-11-11','Eva Road',396,'Pilots','Vendetta','Gales','Francia',222652);
INSERT INTO CIUDADANO VALUES(5112646005637586 , 'Sixto','Otomani','Garabote','1970-07-15','Privada Amilis',23,'Manantiales','Dep.Solaridad','Rocha','Uruguay',500657);
INSERT INTO CIUDADANO VALUES(371695512178268, 'Eulogio','Raimondo','Pascale','1977-07-10','Avenida Elena',39,'Santa','Cusco','Piura','Peru',111652);
INSERT INTO CIUDADANO VALUES(4100147828194738, 'Mauro','Villach','Khatri','1972-05-05','Raducu',532,'Magdalena','Lucia','Valencia','España',34343);
INSERT INTO CIUDADANO VALUES(5077049025312087, 'Elizabeth','Sanchez','Hermosilla','1961-10-12','Santo del jbari',822,'Centro','Ruleta','La union','Salvador',858902);
INSERT INTO CIUDADANO VALUES(4793256103877867, 'Silvia','Sanchez ','De Roman','1993-05-21','Yaakoubi',187,'Tecnologico','Solidaridad','Solola','Guatemala',3226875);
INSERT INTO CIUDADANO VALUES(342054563444573, 'Ezequiel','Adolfo','Soraluce','1969-08-22','Carabobo',375,'Pescadores','Yemaya','Camaguey','Cuba',4665755);
INSERT INTO CIUDADANO VALUES(4638209460804445, 'Parsifal','Grenz','Hitler','1981-08-27','Little',716,'Plainfield','Mecklenburg','Vorpommern','Alemania',449440);
INSERT INTO CIUDADANO VALUES(5227455926592215, 'Burian','Punset','Harti','1981-05-10','Bulevar',156,'Urzay','Santiago','Coquimbo','Chile',8546736);
INSERT INTO CIUDADANO VALUES(4691318749906238, 'Ane','Crispi','Galstyan','1970-05-05','Ivan',632,'Martires','Asuncion','Los Santos','Panama',6923431);
INSERT INTO CIUDADANO VALUES(5324805857913057, 'Santiago','Berganzo','Aspe','1971-10-23','Esquerre',672,'Castores','Lazaro Cardenas','Campeche','Mexico',501296);
INSERT INTO CIUDADANO VALUES(372513972072955, 'Houston','Uliber','Lees','1991-07-07','Way',540,'Garfil','Orange','Utha','EE.UU',3862077);
INSERT INTO CIUDADANO VALUES(487018465522973, 'Kaitlin','Kodak','Siegel','1986-08-26','Park',247,'Bagwell','Sweeper','Missouri','EE.UU',8952421);
INSERT INTO CIUDADANO VALUES(146200343363545 , 'Paz','Solana','Chamoso','1992-11-1','Real',134,'Israel','Macayo','Huila','Colombua',33114265);
INSERT INTO CIUDADANO VALUES(5300738201662633 , 'Salma','Cofrese','Casillas','1985-09-6','Ayra',866,'Lascurain','La Guajira','Cali','Colombia',3217368);
INSERT INTO CIUDADANO VALUES(4008715779004636, 'Lana','Tatiana','Dudau','1985-09-12','Cosp',248,'Yesa','Maduro','Barinas','Venezuela',9777561);
INSERT INTO CIUDADANO VALUES(382753263321964 , 'Erwin','Karl','Palacio','1970-04-10','Hijarrubia',723,'Abollo','Quetzal','Tarija','Bolivia',7262621);

SELECT * FROM CIUDADANO;

INSERT INTO PERIODICO 
VALUES('Reforma', 'Avenida Universidad', 40, 'Santa Cruz Atoyac', 'Benito Juárez', 'Ciudad de México', 'México', 131625);
INSERT INTO PERIODICO 
VALUES('El Universal', 'Bucareli', 8, 'Centro', 'Cuauhtémoc', 'Ciudad de México', 'México', 180000);
INSERT INTO PERIODICO 
VALUES('La Prensa', 'Badillo', 29, 'Centro', 'Cuauhtémoc', 'Ciudad de México', 'México', 244299);
INSERT INTO PERIODICO 
VALUES('OGlobo', 'R. Fernandes Guimarães', 43, 'Botcol', 'Botafogo', 'Rio de Janeiro', 'Brasil', 117721);
INSERT INTO PERIODICO 
VALUES('Folha', 'Alameda Barão de Limeira', 425, 'Cecicol', 'Santa Cecilia', 'São Paulo', 'Brasil', 297927);
INSERT INTO PERIODICO 
VALUES('Correio Braziliense', 'Canteiro Central', 0, 'Trecol', 'SIA Trecho', 'Sia Sul', 'Brasil', 360450);
INSERT INTO PERIODICO 
VALUES('La Nacion', 'General Alvear', 184, 'Corcol', 'Córdoba', 'Córdoba', 'Argentina', 159486);
INSERT INTO PERIODICO 
VALUES('Fin del Mundo', 'Hipólito Bouchard', 667, 'Ushucol', 'Ushuaia', 'Patagonia', 'Argentina', 110125);
INSERT INTO PERIODICO 
VALUES('New York Times', 'W Main St', 101, 'Newcol', 'Norfolk', 'VA', 'EE.UU.', 1066540);
INSERT INTO PERIODICO 
VALUES('Bild', 'Emmeransstraße', 27, 'Ransstracol', 'Maiania', 'Mainz', 'Alemania', 5674400);
INSERT INTO PERIODICO 
VALUES('The Sun', 'Queen St', 57, 'Hallcol', 'Guild Hall', 'Glasgow', 'Inglaterra', 3718354);
INSERT INTO PERIODICO 
VALUES('Yomiuri Shimbun', 'Chome', 71, 'Chiyocol', 'Otemachi', 'Chiyoda', 'Japón', 14532694 );
INSERT INTO PERIODICO 
VALUES('Asahi Shimbun', 'Chome', 32, 'Tsukcol', 'Tsukiji', 'Chūō-ku', 'Japón', 12601375);
INSERT INTO PERIODICO 
VALUES('Wall Street Journal', 'Connecticut Ave NW', 1025, 'Newcol', 'Norfolk', 'Washington', 'EE. UU.', 1740450);
INSERT INTO PERIODICO 
VALUES('Washington Post', 'K St NW', 1301, 'Newcol', 'Surfolk', 'Washington', 'EE. UU.', 759122);
INSERT INTO PERIODICO 
VALUES('O Estado de Sao Paulo', 'Av. Eng. Caetano Álvares', 55, 'Mãocol', 'Limão', 'São Paulo', 'Brasil', 1230160);
INSERT INTO PERIODICO VALUES('Clarin', 'Santa Fe', 3000, 'San Martin', 'Asuncion', 'Buenos Aires', 'Argentina', 238999);
INSERT INTO PERIODICO VALUES('Pagina_12', 'Solis',1525 , 'Ciudadela', 'Andalucia', 'Buenos Aires', 'Argentina', 568872);
INSERT INTO PERIODICO VALUES('La_Razon', 'Alvear',184 , 'Centro', 'General Quintana', 'Villa María', 'Argentina', 4545668);
INSERT INTO PERIODICO VALUES('USA_Today', 'Miramar',33025 , 'Palm', 'Marlberry', 'Florida', 'EE.UU',988872 );
INSERT INTO PERIODICO VALUES('Expreso', 'Luis Carranza', 2289, 'Cercado', 'General Anaya', 'Lima', 'Peru', 15081 );
INSERT INTO PERIODICO VALUES('El_Comercio', 'San Borja', 15021, 'San Javier', 'Prado Este', 'Lima', 'Peru', 17892);
INSERT INTO PERIODICO VALUES('El_Espectador', 'Calle 103', 6943, 'Distoyota', 'Electrofisiatria', 'Bogota', 'Colombia',457722 );
INSERT INTO PERIODICO VALUES('La_Republica', 'Rio frio',530 , 'Tabio', 'Zipaquira', 'Cali', 'Colombia',7889999 );
INSERT INTO PERIODICO VALUES('El_mundo', 'Av. de la República Argentina', 25, 'Mali', 'Cortez', 'Malaga', 'España', 8979695);

SELECT * FROM PERIODICO;

INSERT INTO CASO
VALUES('19001', 'AVE', 'Cohecho', 10000000.00, 'Mexico', 'Reforma', '2015-3-12', 0);
INSERT INTO CASO
VALUES('19003', 'Arena', 'Malversación de recursos públicos', 1000000.00, 'Brasil', 'Correio Braziliense', '2016-2-20', 1);
INSERT INTO CASO
VALUES('19009', 'Astapa', 'Cohecho', 12000000.00, 'Alemania', 'Bild', '2001-1-11', 0);
INSERT INTO CASO
VALUES('19305', 'Casa Blanca', 'Malversación de recursos públicos', 3000000.00, 'Mexico', 'La Prensa', '2002-2-23', 1);
INSERT INTO CASO
VALUES('18001', 'Nuño', 'Cohecho', 1000000.00, 'Brasil', 'Correio Braziliense', '2017-1-12', 0);
INSERT INTO CASO
VALUES('17051', 'Baltar', 'Malversación de recursos públicos', 1000000.00, 'Japon', 'Asahi Shimbun', '2003-12-1', 1);
INSERT INTO CASO
VALUES('19022', 'ICA CARSO', 'Cohecho', 10000000.00, 'EE.UU.', 'Washington Post', '2005-7-3', 0);
INSERT INTO CASO
VALUES('12221', 'Paso Express', 'Malversación de recursos públicos', 1000000.00, 'EE.UU.', 'Washington Post', '2015-7-2', 1);
INSERT INTO CASO
VALUES('19049', 'Caballo de Troya', 'Tráfico de influencias', 12000000.00, 'Alemania', 'Bild', '2015-7-2', 0);
INSERT INTO CASO
VALUES('11021', 'CAM', 'Tráfico de influencias', 13000000.00, 'EE.UU.', 'Wall Street Journal', '2015-7-2', 1);
INSERT INTO CASO
VALUES('19099', 'CCM', 'Cohecho', 500000.00, 'Alemania', 'The Sun', '2016-2-20', 0);
INSERT INTO CASO
VALUES('15631', 'CCM', 'Cohecho', 500000.00, 'Alemania', 'The Sun', '2016-2-20', 1);
INSERT INTO CASO
VALUES('19010', 'Wal Mart', 'Malversación de recursos públicos', 500000.00, 'Mexico', 'La Prensa', '2017-1-12', 0);
INSERT INTO CASO
VALUES('23001', 'Wal Mart', 'Malversación de recursos públicos', 1000000.00, 'EE.UU.', 'Wall Street Journal', '2017-1-12', 1);
INSERT INTO CASO
VALUES('29001', 'Marea', 'Cohecho', 1000000.00, 'EE.UU.', 'Wall Street Journal', '2001-1-11', 0);
INSERT INTO CASO
VALUES('99001', 'Marea', 'Cohecho', 1000000.00, 'EE.UU.', 'Wall Street Journal', '2001-1-11', 1);
INSERT INTO CASO VALUES('19500','Petrobras','Soborno',200000000.00,'Brasil','O Estado de Sao Paulo','2015-06-12',1);
INSERT INTO CASO VALUES('19502','ChinaCommunications','Fraude',100000000.00,'China','Bild','2010-08-02',1);
INSERT INTO CASO VALUES('19503','Blanco Espiritu','Soborno',5000000000,'Portugal','Bild','2009-04-25',1);
INSERT INTO CASO VALUES('19504','Libia','Desvio de fondos',1000000000,'Libia','La_Republica','2008-11-25',0);
INSERT INTO CASO VALUES('19505','Martinelli','Desvio de fondos',1000000000,'Panama','El_Comercio','2007-12-11',1);
INSERT INTO CASO VALUES('19506','Mubarak','Desvio de fondos',530000000,'Egipto','La Prensa','2009-06-13',0);
INSERT INTO CASO VALUES('19507','Unmask','Fraude',38700000,'España','Reforma','2006-10-11',1);
INSERT INTO CASO VALUES('19508','Adigsa','Fraude',67900000,'España','La_Razon','2012-11-10',0);
INSERT INTO CASO VALUES('19509','Santoyo','Trafico de influencias',140000000,'Colombia','El_Comercio','2012-10-15',1);
INSERT INTO CASO VALUES('19510','Barranquilladero','Peculado',606388000,'Colombia','El_Comercio','1998-08-20',1);
INSERT INTO CASO VALUES('19511','DMG','Soborno',167000,'Colombia','Clarin','2008-11-12',1);
INSERT INTO CASO VALUES('19512','Piramides','Fraude',26000000.00,'Colombia','Clarin','2008-09-11',0);
INSERT INTO caso  VALUES ('5468', 'Presedero', 'No se registro la mercancia completa', '600000.00', 'Argentina', 'Fin del Mundo', '2017-01-15', '0');
INSERT INTO caso  VALUES ('456487', 'Santa Fe', 'Construcción ilicita', '8042130', 'Mexico', 'La Prensa', '2016-05-16', '0');
INSERT INTO caso  VALUES ('84613', 'Banca net', 'Página web falsa, obtine información', '100000000', 'Japon', 'Asahi Shimbun', '2017-07-23', '0');
INSERT INTO caso  VALUES ('456786', 'Isasca ', 'Registro trabajos no se realizaron', '40003000', 'México', 'El Universal', '2017-08-15', '0');
INSERT INTO caso  VALUES ('46768', 'Aduana', 'Registros falsos', '52300', 'Brasil', 'OGlobo', '2017-06-09', '0');
INSERT INTO caso  VALUES ('41324', 'Mar y tierra', 'Empresa maritima soborna a embarcaderos', '45000000', 'Brasil', 'Folha', '2009-11-12', '1');

SELECT * FROM CASO;

INSERT INTO partido VALUES ('Partido_Institucional_Mexicano', 'Insurgentes Norte', '59', 'Buenavista', 'Cuauhtémoc', 'Ciudad de México', 'México', '5555419100');
INSERT INTO partido VALUES ('Partido_Acción_Nacional', 'Coyoacán', '1546', 'del Valle', 'Benito Juárez', 'Ciudad de México', 'México', '5552004000');
INSERT INTO partido VALUES ('Partido_de_la_Revolución_Democrática', 'Benjamín Franklin', '84', 'Escandón', 'Miguel Hidalgo', 'Ciudad de México', 'México', '5510858000');
INSERT INTO partido VALUES ('Partido_del_Trabajo', 'Cuauhtémoc', '47', 'Roma norte', 'Cuauhtémoc', 'Ciudad de México', 'México','5555252727');
INSERT INTO partido VALUES ('Movimiento_Ciudadano', 'Louisiana', '113', 'Nápoles', 'Benito Juárez', 'Ciudad de México', 'México','5511676767');
INSERT INTO partido VALUES ('Partido_Verde', 'Loma Bonita', '18', 'Lomas Altas', 'Miguel Hidalgo', 'Ciudad de México', 'México', '5552545418');
INSERT INTO partido VALUES ('Nueva_Alianza', 'Durango ', '190', 'Roma', 'Cuauhtémoc', 'Ciudad de México', 'México','5536858485');
INSERT INTO partido VALUES ('Partido_Popular', 'Génova', '13', 'Comunidad de Madrid', 'Madrid', 'Madrid', 'España', '915577200');
INSERT INTO partido VALUES ('Partido_Socialista_del_Obrero', 'Ferraz ', '70', 'Comunidad de Madrid', 'Madrid', 'Madrid', 'España', '915820444');
INSERT INTO partido VALUES ('Podemos', 'Zurita', '21', 'Comunidad de Madrid', 'Madrid', 'Madrid', 'España', '9123645789');
INSERT INTO partido VALUES ('Ciudadanos', 'Balmes', '191', 'Comunidad Autonoma Española', 'Barcelona', 'Barcelona', 'España', '24347894123');
INSERT INTO partido VALUES ('Partido_Verde_Nacionalista_Canario', 'Bernabé Rodríguez', '13', '	Comunidad Valenciana', 'Santa Cruz de Tenerife', 'Santa Cruz', 'España', '922292475');
INSERT INTO partido VALUES ('Partido_do_Movimento_Democrático_do_Brasil', 'Rua', '07', 'Conjunto Castelo Branco', 'Bairro Parque Dez de Novembro', 'Manaus-AM', 'Brasil', '9235841515');
INSERT INTO partido VALUES ('Partido_de_la_Social_Democracia_Brasileña', 'L2 Su', '607', 'Quadra', 'Cobertura 2', 'Brasilia', 'Brasil', '6134240500');
INSERT INTO partido VALUES ('Partido_de_la_República', 'Piracicaba', '202', 'Vila Sao Joao', 'Limeira - SP', 'Sao Paulo', 'Brasil', '5555258419');
INSERT INTO partido VALUES ('Partido_Progresista', 'Sebastião Diniz', '361', 'Centro', 'Boa Vista - RR', 'Roraima', 'Brasil', '6132029922');
INSERT INTO partido VALUES ('Partido_Socialista_Brasileño', 'SCLN', '304', 'Bloco A', 'Sobreloja', 'Brasilia', 'Brasil', '6133276405');
INSERT INTO partido VALUES ('Democratic_National_Committee', 'South Capitol', '430', 'Southeast ', 'Washington', 'Washington', 'Estados Unidos','2028638000');

SELECT * FROM PARTIDO;

INSERT INTO juez VALUES(79998342 , '2001-12-11');
INSERT INTO juez VALUES(52428220 ,'2002-11-25');
INSERT INTO juez VALUES(52962491 ,'1999-10-11');
INSERT INTO juez VALUES(52427093 ,'1995-02-28');
INSERT INTO juez VALUES(39625110 , '2005-10-19');
INSERT INTO juez VALUES(4834989387516220, '2003-10-11');
INSERT INTO juez VALUES(378370640277449, '1990-02-28');
INSERT INTO juez VALUES(5491037336042913, '1993-10-28');

SELECT * FROM JUEZ;

INSERT INTO PARTIDOPERIODICO VALUES ('Ciudadanos', 'Reforma');
INSERT INTO PARTIDOPERIODICO VALUES ('Democratic_National_Committee', 'El Universal');
INSERT INTO PARTIDOPERIODICO VALUES ('Movimiento_Ciudadano', 'La Prensa');
INSERT INTO PARTIDOPERIODICO VALUES ('Nueva_Alianza', 'New York Times');
INSERT INTO PARTIDOPERIODICO VALUES ('Partido_Acción_Nacional', 'Folha');
INSERT INTO PARTIDOPERIODICO VALUES ('Partido_del_Trabajo', 'Correio Braziliense');
INSERT INTO PARTIDOPERIODICO VALUES ('Partido_de_la_Revolución_Democrática', 'La Nacion');
INSERT INTO PARTIDOPERIODICO VALUES ('Partido_de_la_República', 'Fin del Mundo');
INSERT INTO PARTIDOPERIODICO VALUES ('Partido_de_la_Social_Democracia_Brasileña', 'OGlobo');
INSERT INTO PARTIDOPERIODICO VALUES ('Partido_do_Movimento_Democrático_do_Brasil', 'O Estado de Sao Paulo');
INSERT INTO PARTIDOPERIODICO VALUES ('Partido_Institucional_Mexicano', 'Reforma');
INSERT INTO PARTIDOPERIODICO VALUES ('Partido_Socialista_Brasileño', 'O Estado de Sao Paulo');
INSERT INTO PARTIDOPERIODICO VALUES ('Partido_Socialista_del_Obrero', 'La Prensa');
INSERT INTO PARTIDOPERIODICO VALUES ('Partido_Verde', 'El Universal');
INSERT INTO PARTIDOPERIODICO VALUES ('Partido_Popular', 'El Universal');



INSERT INTO PARTIDOCIUDADANO
VALUES('Podemos', '91273458569483', 'Contador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Verde_Nacionalista_Canario', '80235960', 'Abogado');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Verde', '79998342', 'Presidente');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Verde', '79962291', 'Senador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Socialista_del_Obrero', '5810664534763737', 'Gobernador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Socialista_del_Obrero', '5681472192101257', 'Vicepresidente');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Socialista_del_Obrero', '5491037336042913', 'Administrador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Socialista_Brasileño', '52987453', 'Contador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Socialista_Brasileño', '52962491', 'Abogado');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Socialista_Brasileño', '52960227', 'Presidente');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Progresista', '52880406', 'Senador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Progresista', '52817196', 'Gobernador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Progresista', '52807753', 'Administrador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Popular', '52755672', 'Contador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Popular', '52710695', 'Abogado');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Popular', '52705875', 'Presidente');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Popular', '52517450', 'Senador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Institucional_Mexicano', '52494004', 'Gobernador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Institucional_Mexicano', '52453801', 'Administrador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Institucional_Mexicano', '52428220', 'Contador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_do_Movimento_Democrático_do_Brasil', '52427093', 'Abogado');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_del_Trabajo', '52355290', 'Presidente');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_del_Trabajo', '52329187', 'Senador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_del_Trabajo', '52265956', 'Gobernador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_del_Trabajo', '52198296', 'Gobernador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_del_Trabajo', '51899077', 'Contador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_de_la_Social_Democracia_Brasileña', '51738984', 'Abogado');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_de_la_Revolución_Democrática', '51650895', 'Presidente');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_de_la_República', '4834989387516220','Senador');
INSERT INTO PARTIDOCIUDADANO
VALUES('Partido_Acción_Nacional', '47009479092929', 'Presidente');
INSERT INTO PARTIDOCIUDADANO
VALUES('Nueva_Alianza', '41547273', 'Abogado');
INSERT INTO PARTIDOCIUDADANO
VALUES('Movimiento_Ciudadano', '39625110', 'Contador');

INSERT INTO CASOCIUDADANO
VALUES ('17051', '123443556456565', 'Acoso');
INSERT INTO CASOCIUDADANO
VALUES ('17051', '19442527', 'Identificacion falsa');
INSERT INTO CASOCIUDADANO
VALUES ('17051', '30396689', 'Portacion de arma');
INSERT INTO CASOCIUDADANO
VALUES ('84613', '348343104528042', 'Acoso');
INSERT INTO CASOCIUDADANO
VALUES ('84613', '374428052262723', 'Identificacion falsa');
INSERT INTO CASOCIUDADANO
VALUES ('19009', '376457205561523', 'Portacion de arma');
INSERT INTO CASOCIUDADANO
VALUES ('19009', '377386494864984', 'Acoso');
INSERT INTO CASOCIUDADANO
VALUES ('19009', '378337723098638', 'Identificacion falsa');
INSERT INTO CASOCIUDADANO
VALUES ('19049', '378370640277449', 'Portacion de arma');
INSERT INTO CASOCIUDADANO
VALUES ('19049', '379650194758822', 'Acoso');
INSERT INTO CASOCIUDADANO
VALUES ('19502', '39559801', 'Identificacion falsa');
INSERT INTO CASOCIUDADANO
VALUES ('19502', '39568175', 'Portacion de arma');
INSERT INTO CASOCIUDADANO
VALUES ('19503', '39625110', 'Acoso');
INSERT INTO CASOCIUDADANO
VALUES ('19503', '41547273', 'Identificacion falsa');
INSERT INTO CASOCIUDADANO
VALUES ('19511', '47009479092929', 'Portacion de arma');
INSERT INTO CASOCIUDADANO
VALUES ('19511', '4834989387516220', 'Acoso');
INSERT INTO CASOCIUDADANO
VALUES ('19512', '51650895', 'Identificacion falsa');
INSERT INTO CASOCIUDADANO
VALUES ('19512', '51738984', 'Portacion de arma');
INSERT INTO CASOCIUDADANO
VALUES ('18001', '51899077', 'Acoso');
INSERT INTO CASOCIUDADANO
VALUES ('19003', '52198296', 'Identificacion falsa');
INSERT INTO CASOCIUDADANO
VALUES ('19003', '52265956', 'Portacion de arma');
INSERT INTO CASOCIUDADANO
VALUES ('456786', '52329187', 'Acoso');
INSERT INTO CASOCIUDADANO
VALUES ('19505', '52355290','Identificacion falsa');
INSERT INTO CASOCIUDADANO
VALUES ('19505', '52427093', 'Portacion de arma');
INSERT INTO CASOCIUDADANO
VALUES ('19509', '52428220', 'Acoso');
INSERT INTO CASOCIUDADANO
VALUES ('19509',  '52453801', 'Identificacion falsa');
INSERT INTO CASOCIUDADANO
VALUES ('19510', '52494004', 'Portacion de arma');
INSERT INTO CASOCIUDADANO
VALUES ('19510', '52517450', 'Acoso');
INSERT INTO CASOCIUDADANO
VALUES ('5468', '52705875', 'Identificacion falsa');
INSERT INTO CASOCIUDADANO
VALUES ('5468', '52710695', 'Portacion de arma');
INSERT INTO CASOCIUDADANO
VALUES ('5468', '52755672', 'Acoso');
INSERT INTO CASOCIUDADANO
VALUES ('41324', '52807753', 'Identificacion falsa');
INSERT INTO CASOCIUDADANO
VALUES ('41324', '52817196', 'Identificacion falsa');
INSERT INTO CASOCIUDADANO
VALUES ('41324', '52880406', 'Acoso');
INSERT INTO CASOCIUDADANO
VALUES ('41324', '52960227', 'Acoso');

INSERT INTO CASOJUEZ 
VALUES (19001, 79998342);
INSERT INTO CASOJUEZ 
VALUES (11021,79998342);
INSERT INTO CASOJUEZ 
VALUES (12221,79998342);
INSERT INTO CASOJUEZ 
VALUES (15631,79998342);
INSERT INTO CASOJUEZ 
VALUES (17051,79998342);
INSERT INTO CASOJUEZ 
VALUES (18001,79998342);
INSERT INTO CASOJUEZ 
VALUES (19001,79998342);
INSERT INTO CASOJUEZ 
VALUES (19003,79998342);
INSERT INTO CASOJUEZ 
VALUES (19009,79998342);
INSERT INTO CASOJUEZ 
VALUES (19010,79998342);
INSERT INTO CASOJUEZ 
VALUES (19022,39625110);
INSERT INTO CASOJUEZ 
VALUES (19049,79998342);
INSERT INTO CASOJUEZ 
VALUES (19099,79998342);
INSERT INTO CASOJUEZ 
VALUES (19305,79998342);
INSERT INTO CASOJUEZ 
VALUES (19500,79998342);
INSERT INTO CASOJUEZ 
VALUES (19502,79998342);
INSERT INTO CASOJUEZ 
VALUES (19503,79998342);
INSERT INTO CASOJUEZ 
VALUES (19504,79998342);
INSERT INTO CASOJUEZ 
VALUES (19505,79998342);
INSERT INTO CASOJUEZ 
VALUES (19506,79998342);
INSERT INTO CASOJUEZ 
VALUES (19507,79998342);
INSERT INTO CASOJUEZ 
VALUES (19508,79998342);
INSERT INTO CASOJUEZ 
VALUES (19509,79998342);
INSERT INTO CASOJUEZ 
VALUES (19510,79998342);
INSERT INTO CASOJUEZ 
VALUES (19511,79998342);
INSERT INTO CASOJUEZ 
VALUES (19512,79998342);
INSERT INTO CASOJUEZ 
VALUES (23001,79998342);
INSERT INTO CASOJUEZ 
VALUES (29001,79998342);
INSERT INTO CASOJUEZ 
VALUES (41324,79998342);
INSERT INTO CASOJUEZ 
VALUES (456487,79998342);
INSERT INTO CASOJUEZ 
VALUES (456786,79998342);
INSERT INTO CASOJUEZ 
VALUES (46768,79998342);
INSERT INTO CASOJUEZ 
VALUES (5468,79998342);
INSERT INTO CASOJUEZ 
VALUES (84613,79998342);
INSERT INTO CASOJUEZ 
VALUES (99001,79998342);



SELECT COUNT(*) FROM CASO;
SELECT COUNT(*) FROM CASOCIUDADANO;
SELECT COUNT(*) FROM CASOJUEZ;
SELECT COUNT(*) FROM CIUDADANO;
SELECT COUNT(*) FROM JUEZ;
SELECT COUNT(*) FROM PARTIDO;
SELECT COUNT(*) FROM PARTIDOCIUDADANO;
SELECT COUNT(*) FROM PARTIDOPERIODICO;
SELECT COUNT(*) FROM PERIODICO;

USE CORRUPCION;

SELECT * FROM PARTIDO;


-- Consulta 1
ALTER TABLE PARTIDO ADD NOMBREPASADO VARCHAR(45),
ADD CONSTRAINT fk_nombrepasado FOREIGN KEY(NOMBREPASADO) REFERENCES PARTIDO(NOMBREPARTIDO);



INSERT INTO partido 
VALUES ('Partido_Institucional_CDMX', 'Insurgentes Norte', '59', 'Buenavista', 'Cuauhtémoc', 'Ciudad de México', 'México', '5555419100', 'Partido_Institucional_Mexicano');
INSERT INTO partido 
VALUES ('XYZ', 'Loma Bonita', '18', 'Lomas Altas', 'Miguel Hidalgo', 'Ciudad de México', 'México', '5552545418', 'Partido_Verde');



-- Consulta 2
SELECT DISTINCT PERIODICO.NOMBREPERIODICO, PERIODICO.CALLEPERIODICO, PERIODICO.NUMEROPERIODICO, PERIODICO.COLONIAPERIODICO, PERIODICO.MUNICIPIOPERIODICO, PERIODICO.ESTADOPERIODICO, PERIODICO.PAISPERIODICO FROM PERIODICO
RIGHT JOIN CASO ON CASO.IDPERIODICO = PERIODICO.NOMBREPERIODICO
ORDER BY PERIODICO.NOMBREPERIODICO;

-- Consulta 3
select CIUDADANO.Nombre, CIUDADANO.IDCIUDADANO from ciudadano
WHERE idCiudadano NOT IN (SELECT CIUDADANO.idCiudadano FROM CIUDADANO
						  RIGHT JOIN CASOCIUDADANO ON CASOCIUDADANO.idCiudadano = CIUDADANO.idCiudadano);


-- Consulta 4

	-- Numero total de casos
    SELECT COUNT(*) AS totalcasos FROM CASO AS casos;
	
    -- Numero de casos de cada juez
    SELECT COUNT(IDJUEZ) AS totaljuez FROM CASOJUEZ AS casosjueces
	GROUP BY IDJUEZ;
    
    
SELECT mayor.idJuez, ciudadano.nombre 
		FROM CIUDADANO, (SELECT CASOSJUECES.*, CASOS.TOTALCASOS 
						FROM (SELECT COUNT(*) AS TOTALCASOS 
                        FROM CASO) 
                        AS CASOS,	(SELECT CASOJUEZ.idJuez, COUNT(*) AS TOTALJUEZ
											FROM CASOJUEZ
											GROUP BY CASOJUEZ.IDJUEZ ) AS CASOSJUECES) 
                                            AS mayor
                                            WHERE mayor.TOTALCASOS = mayor.totaljuez AND CIUDADANO.idCiudadano = mayor.idJuez;
    
    
    
    
    Select casoasi.idJuez, concat(ciudadano.nombre,' ',ciudadano.ApellidoPaterno,' ',ciudadano.ApellidoMaterno) AS nombreCompleto 
FROM ciudadano,(	select asigna.*, casos.contador 
					FROM (	select count(*) as contador 
							from caso
						  ) 
					as casos,  (	select casoJuez.idJuez, count(*) as asignados 
									from casoJuez 
                                    GROUP BY casoJuez.idJuez
								) 
					AS asigna 
				) 
				AS casoasi 
				WHERe casoasi.asignados=casoasi.contador AND ciudadano.idCiudadano=casoasi.idJuez;

-- Consulta 5
select NombrePartido, CallePartido, NumeroPartido, ColoniaPartido, MunicipioPartido, EstadoPartido, PaisPartido from partido
where NombrePartido IN (SELECT NOMBREPASADO FROM PARTIDO
						WHERE NOMBREPARTIDO='XYZ');
-- Raiz de consulta 5
select * from partido
where NombrePartido ='XYZ';

-- Consulta 6

SELECT COUNT(*) FROM CASO;   


SELECT cuenta.NombrePeriodico,cuenta.CallePeriodico,cuenta.NumeroPeriodico,cuenta.MUNICIPIOPERIODICO,cuenta.ESTADOPERIODICO,cuenta.PAISPERIODICO,cuenta.Tiraje FROM
		 (select periodico.*, count(*) AS contador from 
		 	caso inner join periodico on caso.idPeriodico=periodico.NombrePeriodico 
		 	GROUP BY periodico.NombrePeriodico 
		 	order by contador desc) AS cuenta
            having MAX(contador);                   


SELECT cuenta.* FROM (select periodico.*, count(*) AS CasosDescubiertos 
from caso inner join periodico 
on caso.idPeriodico=periodico.NombrePeriodico 
GROUP BY periodico.NombrePeriodico order by CasosDescubiertos desc) AS cuenta
having MAX(CasosDescubiertos);








