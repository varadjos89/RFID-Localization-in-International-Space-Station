-- -----------------------------------------------------
--  INSERT TRIGGER FOR backup_MODULE
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS BACKUP_MODULE_INSERTION;
DELIMITER $$
CREATE TRIGGER BACKUP_MODULE_INSERTION
	AFTER INSERT
	ON MODULE
	FOR EACH ROW
BEGIN
	INSERT INTO MODULE_BACKUP 
    (MODULE_ID, NAME, LOCATION,GROUND_UNIT_ID )
    VALUES (NEW.MODULE_ID, NEW.NAME, NEW.LOCATION,NEW.GROUND_UNIT_ID);
END;
$$

-- -----------------------------------------------------
--  DELETE TRIGGER FOR backup_MODULE
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS BACKUP_MODULE_DELETION;
DELIMITER $$
CREATE TRIGGER BACKUP_MODULE_DELETION
	AFTER DELETE
	ON MODULE
	FOR EACH ROW
BEGIN
	DELETE FROM MODULE_BACKUP
    WHERE MODULE_ID= OLD.MODULE_ID AND NAME= OLD.NAME;

END;
$$

-- -----------------------------------------------------
--  INSERT TRIGGER FOR SYSTEMS_BACKUP
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS BACKUP_SYSTEM_INSERTION;
DELIMITER $$
CREATE TRIGGER BACKUP_SYSTEM_INSERTION
	AFTER INSERT
	ON SYSTEMS
	FOR EACH ROW
BEGIN
	INSERT INTO SYSTEMS_BACKUP
    (SYSTEM_TAG_ID, SYSTEMS_BACKUP.NAME, LOCATION, MODULE_ID, SYSTEMS_BACKUP.CONDITION)
    VALUES (NEW.SYSTEM_TAG_ID, NEW.NAME, NEW.LOCATION, NEW.MODULE_ID,  NEW.CONDITION);
END;
$$

-- -----------------------------------------------------
--  DELETE TRIGGER FOR SYSTEMS_BACKUP
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS BACKUP_SYSTEM_DELETION;
DELIMITER $$
CREATE TRIGGER BACKUP_SYSTEM_DELETION
	BEFORE DELETE
	ON SYSTEMS
	FOR EACH ROW
BEGIN
    DELETE FROM SYSTEMS_BACKUP
    WHERE SYSTEM_TAG_ID= OLD.SYSTEM_TAG_ID;
END;


-- -----------------------------------------------------
--  INSERT TRIGGER FOR drawer_COMPONENTS
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS BACKUP_DRAWER_COMPONENT_INSERTION;
DELIMITER $$
CREATE TRIGGER BACKUP_DRAWER_COMPONENT_INSERTION
	AFTER INSERT
	ON DRAWER_COMPONENTS
	FOR EACH ROW
BEGIN
	INSERT INTO DRAWER_COMPONENTS_BACKUP
    (COMPONENT_TAG, DRAWER_ID, DRAWER_COMPONENTS_BACKUP.NAME , LOCATION, DRAWER_COMPONENTS_BACKUP.CONDITION)
    VALUES (NEW.COMPONENT_TAG, NEW.DRAWER_ID, NEW.NAME , NEW.LOCATION, NEW.CONDITION);
END;
$$

-- -----------------------------------------------------
--  DELETE TRIGGER FOR drawer_COMPONENTS
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS BACKUP_DRAWER_COMPONENT_DELETION;
DELIMITER $$
CREATE TRIGGER BACKUP_DRAWER_COMPONENT_DELETION
	BEFORE DELETE
	ON DRAWER_COMPONENTS
	FOR EACH ROW
BEGIN
    DELETE FROM DRAWER_COMPONENTS_BACKUP
    WHERE COMPONENT_TAG= OLD.COMPONENT_TAG;
END;
$$


-- -----------------------------------------------------
--  INSERT TRIGGER FOR LAB_COMPONENTS
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS BACKUP_COMPONENT_INSERTION;
DELIMITER $$
CREATE TRIGGER BACKUP_COMPONENT_INSERTION
	AFTER INSERT
	ON LAB_COMPONENTS
	FOR EACH ROW
BEGIN
	INSERT INTO LAB_COMPONENTS_BACKUP
    (COMPONENT_TAG, LAB_COMPONENTS_BACKUP.NAME, LOCATION,LAB_COMPONENTS_BACKUP.CONDITION, SECTION_ID)
    VALUES (NEW.COMPONENT_TAG, NEW.NAME, NEW.LOCATION, NEW.CONDITION,  NEW.SECTION_ID);
END;
$$

-- -----------------------------------------------------
--  DELETE TRIGGER FOR LAB_COMPONENTS
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS BACKUP_COMPONENT_DELETION;
DELIMITER $$
CREATE TRIGGER BACKUP_COMPONENT_DELETION
	BEFORE DELETE
	ON LAB_COMPONENTS
	FOR EACH ROW
BEGIN
    DELETE FROM LAB_COMPONENTS_BACKUP
    WHERE COMPONENT_TAG= OLD.COMPONENT_TAG;
END;
$$

-- -----------------------------------------------------
--  DELETE TRIGGER FOR LAB_COMPONENTS
-- -----------------------------------------------------


DROP TRIGGER IF EXISTS LAB_COMPONENTS_CONDITION_INSERTION;
DELIMITER $$
CREATE TRIGGER LAB_COMPONENTS_CONDITION_INSERTION
	AFTER UPDATE
	ON LAB_COMPONENTS
	FOR EACH ROW
BEGIN
	INSERT INTO COMPONENT_CONDITION
    (COMPONENT_TAG, COMPONENT_CONDITION.NAME, LOCATION,COMPONENT_CONDITION.CONDITION)
    VALUES (NEW.COMPONENT_TAG, NEW.NAME, NEW.LOCATION, NEW.CONDITION);
END;
$$




DROP TRIGGER IF EXISTS DRAWER_COMPONENTS_CONDITION_INSERTION;
DELIMITER $$
CREATE TRIGGER DRAWER_COMPONENTS_CONDITION_INSERTION
	AFTER UPDATE
	ON DRAWER_COMPONENTS
	FOR EACH ROW
BEGIN
	INSERT INTO COMPONENT_CONDITION
    (COMPONENT_TAG, COMPONENT_CONDITION.NAME, LOCATION,COMPONENT_CONDITION.CONDITION)
    VALUES (NEW.COMPONENT_TAG, NEW.NAME, NEW.LOCATION, NEW.CONDITION);
END;
$$



DROP TRIGGER IF EXISTS SYSTEM_CONDITION_INSERTION;
DELIMITER $$
CREATE TRIGGER SYSTEM_CONDITION_INSERTION
	AFTER UPDATE
	ON SYSTEMS
	FOR EACH ROW
BEGIN
	INSERT INTO COMPONENT_CONDITION
    (COMPONENT_TAG, COMPONENT_CONDITION.NAME, LOCATION, COMPONENT_CONDITION.CONDITION)
    VALUES (NEW.SYSTEM_TAG_ID, NEW.NAME, NEW.LOCATION,  NEW.CONDITION);
END;
$$
