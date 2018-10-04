/*
 * Create database and user
 */

CREATE SCHEMA eval_C2_C3;
GRANT ALL PRIVILEGES ON eval_C2_C3.* TO 'evaluser'@'localhost' IDENTIFIED BY 'evaluser';

USE eval_C2_C3;


/*
 *  Create tables
 */
CREATE TABLE IF NOT EXISTS articles (
    id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    category_id INTEGER UNSIGNED NOT NULL,
    unit_id INTEGER UNSIGNED NOT NULL,
    sales_price DECIMAL(6,2) NOT NULL,
    INDEX(category_id),
    INDEX(unit_id)
) Engine=InnoDB CHARSET=UTF8;

CREATE TABLE IF NOT exists categories (
    id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE
) Engine=InnoDB CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS units (
    id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE
) Engine=InnoDB CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS suppliers (
    id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE
) Engine=InnoDB CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS article_supplier (
    article_id INTEGER UNSIGNED NOT NULL,
    supplier_id INTEGER UNSIGNED NOT NULL,
    purchase_price DECIMAL(8,2),
    CONSTRAINT fk_article_supplier PRIMARY KEY (article_id, supplier_id)
) Engine=InnoDB CHARSET=UTF8;

CREATE TABLE movements (
    id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    article_id INTEGER UNSIGNED NOT NULL,
    quantity DECIMAL(8,2) NOT NULL,
    date_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    movement_type_id INTEGER UNSIGNED NOT NULL,
    purchase_id INTEGER UNSIGNED NULL,
    sale_id INTEGER UNSIGNED NULL,
    INDEX(article_id),
    INDEX(date_time),
    INDEX(movement_type_id),
    INDEX(purchase_id),
    INDEX(sale_id)
) Engine=InnoDB CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS purchases (
    id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    supplier_id INTEGER UNSIGNED NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX(order_date),
    INDEX(supplier_id)
) Engine=InnoDB CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS sales (
    id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX(sale_date)
) Engine=InnoDB CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS movement_types (
    id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    direction_id INTEGER UNSIGNED NOT NULL
) Engine=InnoDB CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS directions (
    id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    multiplier SMALLINT NOT NULL
) Engine=InnoDB CHARSET=UTF8;

/*
    Create foreign keys
*/
ALTER TABLE articles
    ADD CONSTRAINT fk_article_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT,
    ADD CONSTRAINT fk_article_unit FOREIGN KEY (unit_id) REFERENCES units(id) ON DELETE RESTRICT;

ALTER TABLE article_supplier
    ADD CONSTRAINT fk_article_supplier_article FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE RESTRICT,
    ADD CONSTRAINT fk_article_supplier_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE RESTRICT;

ALTER TABLE movements
    ADD CONSTRAINT fk_movements_article FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE RESTRICT,
    ADD CONSTRAINT fk_movements_movement_type FOREIGN KEY (movement_type_id) REFERENCES movement_types(id) ON DELETE RESTRICT,
    ADD CONSTRAINT fk_movements_purchase FOREIGN KEY (purchase_id) REFERENCES purchases(id) ON DELETE RESTRICT,
    ADD CONSTRAINT fk_movements_sale FOREIGN KEY (sale_id) REFERENCES sales(id) ON DELETE RESTRICT;

ALTER TABLE purchases
    ADD CONSTRAINT fk_purchases_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE RESTRICT;

ALTER TABLE movement_types
    ADD CONSTRAINT fk_movement_types_direction FOREIGN KEY (direction_id) REFERENCES directions(id) ON DELETE RESTRICT;

/*
 *  Create views
 */
CREATE OR REPLACE VIEW current_stock AS
    SELECT SUM(quantity * multiplier) AS Quantity, units.name AS Unit, articles.name AS Article
    FROM
    movements
    JOIN movement_types ON movements.movement_type_id = movement_types.id
    JOIN directions ON movement_types.direction_id = directions.id
    JOIN articles ON movements.article_id = articles.id
    JOIN units ON articles.unit_id = units.id
    GROUP BY articles.name;

CREATE OR REPLACE VIEW total_value AS
    SELECT SUM(quantity * multiplier * sales_price) AS total_value
    FROM
    movements
    JOIN movement_types ON movements.movement_type_id = movement_types.id
    JOIN directions ON movement_types.direction_id = directions.id
    JOIN articles ON movements.article_id = articles.id;

CREATE OR REPLACE VIEW category_value AS
    SELECT SUM(quantity * multiplier * sales_price) AS total_value, categories.name AS category
    FROM
    movements
    JOIN movement_types ON movements.movement_type_id = movement_types.id
    JOIN directions ON movement_types.direction_id = directions.id
    JOIN articles ON movements.article_id = articles.id
    JOIN categories ON articles.category_id = categories.id
    GROUP BY categories.name;
