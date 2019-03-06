-- module Main where
--
-- main :: IO ()
-- main = putStrLn "Hello, Haskell!"

{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

import System.Environment
import Data.Aeson as Q
import Data.Text
import Control.Applicative
import Control.Monad
import qualified Data.ByteString.Lazy as B
import Network.HTTP.Conduit (simpleHttp)
import Control.Exception as X
import GHC.Generics
import Control.Monad (mapM_)
import Prelude

data DataPoint = DataPoint { description :: String
                           } deriving (Show, Generic)

data TempPoint = TempPoint { temp :: Float
                           } deriving (Show, Generic)

data Temperatures = Temperatures { weather :: [DataPoint],
                                   test :: TempPoint
                                 } deriving (Show, Generic)

instance FromJSON Temperatures where {
  parseJSON = withObject "" $ \o ->
    Temperatures <$> o .: "weather" <*> o .: "main"
}
instance ToJSON Temperatures where {
  toJSON p = object [
    "weather" .= weather p,
    "main" .= test p]
}
instance FromJSON DataPoint
instance ToJSON DataPoint
instance FromJSON TempPoint
instance ToJSON TempPoint

jsonURL :: String -> String
jsonURL q = "http://api.openweathermap.org/data/2.5/weather?q=" ++ q ++ "&units=metric&appid=e7b9dd9f41c3ac26eae9e94536c8075e&lang=ru"

statusExceptionHandler ::  SomeException -> IO B.ByteString
statusExceptionHandler e = (putStrLn "Что-то не так") >> (return B.empty)

getJSON :: String -> IO B.ByteString
getJSON town = simpleHttp (jsonURL town) `X.catch` statusExceptionHandler

main :: IO ()
main = do
  args <- getArgs
  parseArgs args

parseArgs :: [String] -> IO()
parseArgs [] = getWeather
parseArgs (x:_) = do
  case x of
    "--help" -> usage
    "--version" -> version
    "--list" -> list
    _ -> getWeather

usage :: IO()
usage = putStrLn usageStr

usageStr :: String
usageStr = "Погодный сервис, работающий с базой Openweathermap.\n" ++
           "Для начала необходимо ввести ваш город на английском или русском языке\n" ++
           "Более подробнее о выборе городов можно узнать по флагу --list\n" ++
           "\n Чикмарёв Илья, 381505 гр. ИИТММ, 2018-2019 гг.\n"

version :: IO()
version = putStrLn versionStr

versionStr :: String
versionStr = "WeatherApp/1.0.1\n" ++
             "© 2018-2019"

list :: IO()
list = putStrLn listStr

listStr :: String
listStr = "Поисковый сервис, очень гибкий.\n" ++
          "Запрос может обрабатываться по любому реальному городу на английском или русском языках\n" ++
          "Введите полное название города или часть.\n" ++
          "Например: Нижний Новгород, Выкса или Городец\n"  ++
          "Чем более точное название города вы поставите, тем более точный список вы получите.\n" ++
          "\n" ++
          "Для уточнения, вы можете поставить после названия или части города запятую, и 2ух буквенный код страны\n" ++
          "Вы получите название городы в выбранной стране.\n" ++
          "Например: Москва, RU или Москва, Russia\n" ++
          "\n" ++
          "Удачи вам!\n"

getWeather :: IO ()
getWeather = do
 putStrLn "Привет! Пожалуйста, введи название своего города >>> \n "
 town <- getLine
 putStrLn ("\nХм, ты ввел город - " ++ town ++ "\nДавай посмотрим, что там за погода")
 d <- (eitherDecode <$> (getJSON town)) :: IO (Either String Temperatures)
 case d of
  Left e -> putStrLn ("Произошла ошибка.\n" ++ "Проверьте правильность написания и наличие подключения к интернету")
  Right stuff -> putStrLn ("Сейчас температура в твоем городе " ++
                            show (temp (test stuff)) ++ " градусов Цельсия \nА на улице – " ++
                            (description (Prelude.head(weather stuff))))
