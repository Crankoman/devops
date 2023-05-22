UPDATE public.clients
set "заказ" = clients.id,
from
('Иванов Иван Иванович', 'Книга'), ('Петров Петр Петрович', 'Монитор'), ('Иоганн Себастьян Бах', 'Гитара')

UPDATE public.clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Книга') WHERE "фамилия"='Иванов Иван Иванович';
UPDATE public.clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Монитор') WHERE "фамилия"='Петров Петр Петрович';
UPDATE public.clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Гитара') WHERE "фамилия"='Иоганн Себастьян Бах';