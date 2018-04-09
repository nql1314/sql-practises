CREATE TABLE book (
  bookid INT NOT NULL,
  bookname VARCHAR (255) NOT NULL,
  AUTHORS VARCHAR (255) NOT NULL,
  info VARCHAR (255) NULL,
  COMMENT VARCHAR (255) NULL,
  year_publication YEAR NOT NULL
);

#创建INDEX语法
CREATE [UNIQUE|FULLTEXT|SPATIAL]  INDEX index_name
ON table_name(col_name[length],...)  [ASC|DESC]

#普通索引
CREATE INDEX BkNameIdx ON book(bookname);

#建立唯一索引
CREATE UNIQUE INDEX UniqueIdIdx ON book(bookId);

#创建复合索引
CREATE INDEX BkAuAndInfoIdx ON book(AUTHORS(20),info(50));

#建立全文索引
DROP TABLE IF EXISTS t6;
CREATE TABLE t6
(
  id INT NOT NULL,
  info CHAR(255)
)ENGINE= MYISAM;
CREATE FULLTEXT INDEX infoFTIdx ON t6(info);

#建立空间索引
DROP TABLE IF EXISTS t7;
CREATE TABLE t7(g GEOMETRY NOT NULL)ENGINE=MYISAM;
CREATE SPATIAL  INDEX spatIdx ON t7(g);

#删除索引
ALTER TABLE table_name DROP INDEX index_name;
DROP INDEX index_name ON table_name