#创建触发器
CREATE TRIGGER trigger_name trigger_time trigger_event
ON tbl_name FOR EACH ROW trigger_stmt;

CREATE TABLE account(acct_num INT ,amount DECIMAL(10,2));
CREATE TRIGGER updatesum2 BEFORE UPDATE ON account
  FOR EACH ROW SET @SUM = @SUM+new.amount;
INSERT INTO account VALUES(1,1.00),(2,2.00);
SHOW TRIGGERS ;