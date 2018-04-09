#存储过程创建
DELIMITER //
  CREATE PROCEDURE myproc(OUT  s INT)
    BEGIN
      SELECT count(*) INTO s FROM students;
    END //
DELIMITER ;


#存储过程变量作用域
DELIMITER //
CREATE PROCEDURE proc()
  BEGIN
    DECLARE x1 VARCHAR(5) DEFAULT 'outer';
    BEGIN
      DECLARE x1 VARCHAR(5) DEFAULT 'inner';
      SELECT x1;    #inner
    END;
    SELECT x1;    #outer
  END;
//
DELIMITER ;

#条件语句IF-THEN-ELSE
DROP PROCEDURE IF EXISTS proc3;
DELIMITER //
CREATE PROCEDURE proc3(IN parameter int)
  BEGIN
    DECLARE var int;
    SET var=parameter+1;
    IF var=0 THEN
      INSERT INTO t VALUES (17);
    END IF ;
    IF parameter=0 THEN
      UPDATE t SET s1=s1+1;
    ELSE
      UPDATE t SET s1=s1+2;
    END IF ;
  END ;
//
DELIMITER ;

#CASE-WHEN-THEN-ELSE语句
DELIMITER //
CREATE PROCEDURE proc4 (IN parameter INT)
  BEGIN
    DECLARE var INT;
    SET var=parameter+1;
    CASE var
      WHEN 0 THEN
      INSERT INTO t VALUES (17);
      WHEN 1 THEN
      INSERT INTO t VALUES (18);
    ELSE
      INSERT INTO t VALUES (19);
    END CASE ;
  END ;
//
DELIMITER ;

#WHILE-DO...END-WHILE语句
DELIMITER //
CREATE PROCEDURE proc5()
  BEGIN
    DECLARE var INT;
    SET var=0;
    WHILE var<6 DO
      INSERT INTO t VALUES (var);
      SET var=var+1;
    END WHILE ;
  END;
//
DELIMITER ;

#REPEAT...END REPEAT
DELIMITER //
CREATE PROCEDURE proc6 ()
  BEGIN
    DECLARE v INT;
    SET v=0;
    REPEAT
      INSERT INTO t VALUES(v);
      SET v=v+1;
    UNTIL v>=5
    END REPEAT;
  END;
//
DELIMITER ;

#LOOP...END LOOP
DELIMITER //
CREATE PROCEDURE proc7 ()
  BEGIN
    DECLARE v INT;
    SET v=0;
    LOOP_LABLE:LOOP
      INSERT INTO t VALUES(v);
      SET v=v+1;
      IF v >=5 THEN
        LEAVE LOOP_LABLE;
      END IF;
    END LOOP;
  END;
//
DELIMITER ;