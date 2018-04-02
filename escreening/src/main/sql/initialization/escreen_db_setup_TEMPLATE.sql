/* This script requires global privilates and only needs to be run once per mysql install*/

/* set root user password */
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('CHANGE_M3');

/* add logging */
SET GLOBAL general_log = 'ON';

/* create database user - CHANGE PASSWORD! */
CREATE USER 'escrapp'@'localhost' IDENTIFIED BY 'CHANGE_M3';

/* create site database - replace <site> with 3-letter facility abbreviation */
CREATE DATABASE IF NOT EXISTS <site>mhe;


/* grant database user permission to database - replace <site> with 3-letter facility abbreviation */
GRANT ALL ON <site>mhe.* TO 'escrapp'@'localhost';
