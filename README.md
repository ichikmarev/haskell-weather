# WeatherApp

**The study project on Haskell language to take JSON from open weather map API and parse it to user**

**Студенческий проект на языке Haskell в в рамках курса "Функциональное программирование" студента гр. 381505 ИИТММ, Чикмарёва Ильи**

WeatherApp

Проект делает запрос к открытой базе API openweathermap, подставляет запрос и выводит погоду по данному городу. Для работы понадобится интернет соединение.

*Запуск:*

Для первоначальной настройки необходимо иметь предустановленную Haskell Platform. После этого в корневом каталоге выполнить команды:

```bash
$ cabal configure
$ cabal build
```

Возможны ошибки в загрузках дополнительных модулей, в этому случаее рекомендуется выполнить следующие команды:

```bash
$ cabal clean
$ cabal install --only-dependencies
$ cabal configure
$ cabal build
```

*Далее можно приступать к работе с программой*

Запуск файла из командной строки:

```bash
  dist/build/WeatherApp/WeatherApp
```

Ключ "--help" служит для инструкции пользователя

```bash
  dist/build/WeatherApp/WeatherApp --help
```

Ключ "--version" служит для вывода актульной версии сборки и кредитов

```bash
  dist/build/WeatherApp/WeatherApp --version
```

Ключ "--list" служит для вывода списка городов и модификаций

```bash
  dist/build/WeatherApp/WeatherApp --list
```
