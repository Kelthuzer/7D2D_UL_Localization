# Undead Legacy v2.6 — сравнение локализации

Здесь лежит текущая русская локализация для Undead Legacy v2.6 и материалы для её проверки относительно `English.txt`.

## Сравнение English → Russian

- **[Интерактивная страница сравнения](https://kelthuzer.github.io/7D2D_UL_Localization/V2.6/compare.html)** — поиск по ключу/тексту и фильтры `EN = RU`, `RU override`, `RU only`, `MISSING RU`.
- **[Полная CSV-таблица](./TRANSLATION_REVIEW_V2.6.csv)** — `номер | ключ | Английское содержание | Русское`.
- [English.txt](./Mods/UndeadLegacy/Config/Localization/English.txt)
- [Russian.txt](./Mods/UndeadLegacy/Config/Localization/Russian.txt)

### Состояние сверки

| Проверка | Результат |
|---|---:|
| Строк в English | 7291 |
| Строк в Russian | 7350 |
| Уникальных ключей English | 7285 |
| Уникальных ключей Russian | 7331 |
| Пропущенных английских ключей в Russian | **0** |
| Дополнительных строк Russian после основного набора | **59** |
| Уникальных RU-only ключей | 46 |

Первые **7291** записей `Russian.txt` соответствуют `English.txt` по последовательности ключей. Оставшиеся **59** строк — сохранённый блок дополнительных/повторных vanilla/UI override-ключей, в том числе компактные подписи интерфейса.
