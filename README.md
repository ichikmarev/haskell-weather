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

Для корректной работы программы необходим данный списка модулей:

```bash
aeson,
base,
base-compat,
bytestring,
text,
http-conduit
```

Для установки данных зависимостей рекомендуется выполнить следующие команды:

```bash
$ cabal install --only-dependencies
```

или установить каждый пакет отдельно:

```bash
$ cabal install [package name]
$ cabal install http-conduit
```

После установки всех зависимостей можно запускать проект:

```bash
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
