INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_rockford','Rockfords studio',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_rockford','Rockfords studio',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_rockford', 'Rockfords studio', 1)
;

INSERT INTO `jobs` (`name`, `label`) VALUES
('rockford', 'Rockfords studio');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('rockford', 0, 'stagaire', 'Stagaire', 100, 'null', 'null'),
('rockford', 1, 'employe', 'employe', 200, 'null', 'null'),
('rockford', 2, 'responsable', 'Responsable', 300, 'null', 'null'),
('rockford', 3, 'boss', 'Patron', 400, 'null', 'null');