# Undead Legacy v2.6 — сравнение локализации

Эта страница предназначена для проверки русской локализации относительно текущего `English.txt`.

## Полное сравнение English → Russian

**[Открыть полную таблицу сравнения ключей](./TRANSLATION_REVIEW_V2.6.csv)**

Формат таблицы:

| номер | ключ | Английское содержание | Русское |
|---:|---|---|---|
| 1 | `campfireActivate` | Open Campfire | Осмотреть костёр |
| 2 | `caffeineBuzz` | Caffeine Rush | Кофеиновый бодряк |
| 3 | `caffeineBuzzDesc` | Caffeine gives you energy... | Кофеин дает вам энергию... |

Исходные файлы:

- [English.txt](./Mods/UndeadLegacy/Config/Localization/English.txt)
- [Russian.txt](./Mods/UndeadLegacy/Config/Localization/Russian.txt)

## Проверка ключей

| Проверка | Результат |
|---|---:|
| Строк в `English.txt` | **7093** |
| Уникальных ключей в `English.txt` | **7087** |
| Строк в `Russian.txt` | **7152** |
| Уникальных ключей в `Russian.txt` | **7133** |
| Ключей English, отсутствующих в Russian | **0** |
| Дополнительных ключей только в Russian | **46** |

**Все ключи текущего `English.txt` присутствуют в `Russian.txt`.** Дополнительные русские ключи — legacy/UI overrides, сохранённые для совместимости и компактного интерфейса.

<details>
<summary>46 дополнительных ключей Russian</summary>

```text
DOWN_VANILA_FIX_REMEBER_COPY
ZombieRNGRange
ammoJunkTurretRegular
ammoJunkTurretShell
drinkJarGrandpasAwesomeSauce
drinkJarGrandpasLearningElixir
drinkJarGrandpasMoonshine
drugRockBusters
drugSugarButts
electrictimerrelay
foodBaconAndEggs
foodBakedPotato
foodBlueberryPie
foodBoiledMeat
foodCanSham
foodChiliDog
foodCornBread
foodFishTacosS
foodGrilledMeat
foodGumboStew
foodHoboStew
foodMeatStew
foodPumpkin
foodPumpkinCheesecake
foodPumpkinPie
foodShepardsPie
foodSpaghetti
foodSteakAndPotato
foodTunaFishGravyToast
foodVegetableStew
goBlockDamageAIBM
goDayLightLength
gunMGT1AK47Parts
inpGrpMpName
lblContextActionHeal
lblContextActionModify
medicalAloeCream
medicalFirstAidBandage
meleeClubIron
meleeClubIronDesc
miscellaneous
questRewardGyrocopterPartsBundle
statEntityDamageRanged
statPowerCondition
xuiGenWilderness
xuiRestock
```

</details>

## Повторяющиеся ключи

В исходном английском файле уже есть 6 повторяющихся ключей:

`ulmSleeperScorpionBlood`, `ulmSleeperScorpionRadiatedBoss`, `ulmVehicleServiceTruck`, `waterTip`, `waterTipDesc`, `xuiInventory`.

В русском файле повторяются 19 ключей. Часть повторов приходит из исходника, часть относится к намеренным UI/vanilla overrides:

`alternateAmmoTip`, `alternateAmmoTipDesc`, `ammoJunkTurretRegular`, `bluff01`, `electricwirerelay`, `flyingHelicoptersTip`, `flyingHelicoptersTipDesc`, `inpActDebugGameEventName`, `thrownAmmoMolotovCocktail`, `typeFoliage`, `uiKeyLockSlot`, `uiKeyPrimary`, `uiKeySecondary`, `ulmSleeperScorpionBlood`, `ulmSleeperScorpionRadiatedBoss`, `ulmVehicleServiceTruck`, `waterTip`, `waterTipDesc`, `xuiInventory`.

## Состояние проверки

`Russian.txt`, загруженный в репозиторий, совпадает с подготовленным файлом по содержимому. При загрузке был удалён только UTF-8 BOM (3 служебных байта); текст и строки локализации не изменились.
