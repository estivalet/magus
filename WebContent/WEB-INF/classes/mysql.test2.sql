
CREATE TABLE wishers
(
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  name CHAR(50) CHARACTER SET utf8 NOT NULL UNIQUE,
  password CHAR(50) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB;

CREATE TABLE wishes
(
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  wisher_id INT NOT NULL,
  description CHAR(255) CHARACTER SET utf8 NOT NULL,
  due_date DATE,
  FOREIGN KEY (wisher_id) REFERENCES wishers(id)
) ENGINE=InnoDB;


INSERT INTO wishers (name, password) 
                VALUES ('Tom', 'tomcat');
                
INSERT INTO wishers (name, password) 
                VALUES ('Jerry', 'jerrymouse');

INSERT INTO wishes (wisher_id, description, due_date) 
                    VALUES (1, 'Sausage', 080401);
                    
INSERT INTO wishes (wisher_id, description) 
                    VALUES (1, 'Icecream');
                    
INSERT INTO wishes (wisher_id, description, due_date) 
                    VALUES (2, 'Cheese', 080501);
                    
INSERT INTO wishes (wisher_id, description)
                    VALUES (2, 'Candle');
                    

