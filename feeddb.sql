INSERT INTO units (id, name)
VALUES
(1, 'Litres'),
(2, 'Kg'),
(3, 'Unités'),
(4, 'Bouteilles');

INSERT INTO categories (id, name)
VALUES
(1, 'Alimentation'),
(2, 'Boissons'),
(3, 'Produits ménagers');

INSERT INTO articles (id, name, category_id, unit_id, sales_price)
VALUES
(1, 'Eau minérale', 2, 3, 1.00),
(2, 'Spaghetti', 1, 2, 0.5),
(3, 'Serpillière', 3, 3, 2.00),
(4, 'Coca Cola 50cl', 2, 4, 0.50),
(5, 'Baguette', 1, 3, 1.00),
(6, 'Éponge', 3, 3, 0.20);

INSERT INTO suppliers (id, name)
VALUES
(1, 'Ménagers Grossiste'),
(2, 'France Boissons'),
(3, 'Boulangerie industrielle'),
(4, 'Mespoulet'),
(5, 'Boulangerie artisanale'),
(6, 'Les pâtes italiennes'),
(7, 'Produits italiens');

INSERT INTO article_supplier (article_id, supplier_id, purchase_price)
VALUES
(1, 2, 0.35),
(1, 4, 0.37),
(2, 6, 0.20),
(2, 7, 0.35),
(3, 1, 0.99),
(4, 2, 0.21),
(4, 4, 0.20),
(5, 3, 0.40),
(5, 5, 0.85),
(6, 1, 0.09);

INSERT INTO directions (id, name, multiplier)
VALUES
(1, 'Entrée', 1),
(2, 'Sortie', -1);

INSERT INTO movement_types (id, name, direction_id)
VALUES
(1, 'Achat', 1),
(2, 'Vente', 2),
(3, 'Perte', 2),
(4, 'Vol', 2);

INSERT INTO purchases (id, order_date, supplier_id)
VALUES
(1, CURRENT_TIMESTAMP, 1),
(2, CURRENT_TIMESTAMP, 2),
(3, CURRENT_TIMESTAMP, 3),
(4, CURRENT_TIMESTAMP, 4),
(5, CURRENT_TIMESTAMP, 5),
(6, CURRENT_TIMESTAMP, 6),
(7, CURRENT_TIMESTAMP, 7);

INSERT INTO movements (article_id, movement_type_id, purchase_id, quantity)
VALUES
(3, 1, 1, 100),
(6, 1, 1, 1000),
(1, 1, 2, 200),
(4, 1, 2, 400),
(5, 1, 3, 50),
(1, 1, 4, 200),
(4, 1, 4, 500),
(5, 1, 5, 100),
(2, 1, 6, 100),
(2, 1, 7, 100);
