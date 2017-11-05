CREATE DATABASE `entrada` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE `entrada_auth` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE `entrada_clerkship` CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL ON entrada.* TO 'entrada';
GRANT ALL ON entrada_auth.* TO 'entrada';
GRANT ALL ON entrada_clerkship.* TO 'entrada';
