# Undead Legacy — Russian Localization

Русская локализация для мода **Undead Legacy** в игре **7 Days to Die**.

Перевод оформлен как отдельный модлет и устанавливается в папку `Mods`, не заменяя оригинальные файлы Undead Legacy напрямую.

## Состав

```text
UndeadLegacy_Localization_Russian/
├── Config/
│   └── Localization.txt
├── ModInfo.xml
└── Update_locale_win10.bat
```

## Установка

1. Скачайте репозиторий или папку `UndeadLegacy_Localization_Russian`.
2. Поместите папку в директорию `Mods` игры.

Пример пути для Steam-версии Windows:

```text
...\Steam\steamapps\common\7 Days To Die\Mods\UndeadLegacy_Localization_Russian
```

Итоговая структура должна быть такой:

```text
7 Days To Die/
└── Mods/
    └── UndeadLegacy_Localization_Russian/
        ├── Config/
        │   └── Localization.txt
        ├── ModInfo.xml
        └── Update_locale_win10.bat
```

3. Запустите игру.
4. Убедитесь, что установлен и работает оригинальный **Undead Legacy**.

## Обновление локализации

Для Windows можно использовать файл:

```text
Update_locale_win10.bat
```

Он скачивает актуальный `Localization.txt` из этого репозитория и заменяет локальный файл в папке `Config`.

Запускать файл нужно из папки мода:

```text
Mods\UndeadLegacy_Localization_Russian\Update_locale_win10.bat
```

## Ручное обновление

Если батник не работает:

1. Откройте файл в репозитории:

```text
Mods/UndeadLegacy_Localization_Russian/Config/Localization.txt
```

2. Скачайте его.
3. Замените локальный файл:

```text
Mods/UndeadLegacy_Localization_Russian/Config/Localization.txt
```

## Требования

* **7 Days to Die**
* Установленный мод **Undead Legacy**
* Папка `Mods` в корне игры

## Возможные проблемы

### Локализация не применяется

Проверьте:

* папка мода лежит именно в `7 Days To Die/Mods`;
* внутри папки есть `ModInfo.xml`;
* файл локализации находится по пути `Config/Localization.txt`;
* оригинальный Undead Legacy установлен и загружается;
* нет другой локализации, которая перезаписывает те же строки.

### После обновления часть текста осталась на английском

Возможные причины:

* в Undead Legacy добавлены новые строки, которые ещё не переведены;
* используется другая версия Undead Legacy;
* другая модификация изменила ключи локализации.

## Авторы

* Kelthuzer
* Schmarotzer

## Статус

Проект находится в разработке. Перевод может обновляться по мере выхода новых версий Undead Legacy.

## Лицензия

Локализация распространяется как фанатский перевод. Все права на **7 Days to Die** и **Undead Legacy** принадлежат их правообладателям.
