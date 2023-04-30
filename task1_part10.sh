#!/bin/bash
#Part 10: Mariadb
#1- install mariadb from the local repo that was created earlier.
#2- open ports in iptables from mariadb.
#3- create database , user(note: handle permissions).
#4- connect to the database created in step 3 using the new user (with password)

sudo yum install galera-4 MariaDB-common MariaDB-client MariaDB-client-debuginfo MariaDB-server MariaDB-compat MariaDB-devel MariaDB-gssapi-server MariaDB-gssapi-server-debuginfo MariaDB-shared MariaDB-test -y

systemctl start mysql
systemctl enable mysql

sudo iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
mysql -u root << EOF
drop database if exists studentdb;
create database studentdb;
drop user if exists user@localhost;
create user 'user'@'localhost' identified by 'pass';
grant all privileges on studentdb.* to 'user'@'localhost';
flush privileges;
exit
EOF

mysql -u user -ppass<< EOF
use studentdb;
create table students(
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    program VARCHAR(50) NOT NULL,
    grad_year INT NOT NULL,
    student_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
);
insert into students(first_name,last_name,program,grad_year,student_number) values 
('Allen', 'Brown', 'mechanical', '2017', '110-001'),
('David', 'Brown', 'mechanical', '2017', '110-002'),
('Mary', 'Green', 'mechanical', '2018', '110-003'),
('Dennis', 'Green', 'electrical', '2018', '110-004'),
('Joseph', 'Black', 'electrical', '2018', '110-005'),
('Dennis', 'Black', 'electrical', '2020', '110-006'),
('Ritchie', 'Salt', 'computer science', '2020', '110-007'),
('Robert', 'Salt', 'computer science', '2020', '110-008'),
('David', 'Suzuki', 'computer science', '2020', '110-009'),
('Mary', 'Chen', 'computer science', '2020', '110-010');
select * from students;
exit
EOF
