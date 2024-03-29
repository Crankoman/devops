# Домашнее задание к занятию «Введение в микросервисы»

## Задача

Руководство крупного интернет-магазина,
у которого постоянно растёт пользовательская база и количество заказов,
рассматривает возможность переделки своей внутренней ИТ-системы на основе микросервисов. 

Вас пригласили в качестве консультанта для
оценки целесообразности перехода на микросервисную архитектуру. 

Опишите, какие выгоды может получить компания от перехода
на микросервисную архитектуру и какие проблемы нужно решить в первую очередь.

<--

Ответ:

1. Преимущества
   1. Возможность горизонтального масштабирования наиболее нагруженных частей;
   2. Упрощение разработки и сопровождения отдельных микросервисов по сравнению монолитом;
   3. Возможность использовать разные технологии для разных микросервисов (например, использование компилируемых или неблокирующих синхронизацию решений, там где это даст преимущества);
   4. Уменьшение времени выкатки изменений, при правильном разделении на микросервисы.

2. Какие проблемы нужно решить в первую очередь;
   1. Проанализировать текущую инфрастуктуру и текущее решение;
   2. Выявить текущие узкие места и начать выделение от монолита того функционала который можно распараллеливать;
   3. Убедиться что у сотрудников(разработка и сопровождение) есть необходимые компетенции, при необходимости направить на обучение;
   4. Составить план перехода и запланировать дополнительные вычислительные ресурсы;
   5. Настроить эффективный мониторинг и систему сбору логов для учета новой парадигмы.
   6. Внедрить при необходимости CI/CD инструменты под новую парадигму;
   7. Продумать системы балансировки и настроить DEV и PROD окружение.

---