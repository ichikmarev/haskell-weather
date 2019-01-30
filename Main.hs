-- module Main where
--
-- main :: IO ()
-- main = putStrLn "Hello, Haskell!"

{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

import Data.Aeson as Q
import Data.Text
import Control.Applicative
import Control.Monad
import qualified Data.ByteString.Lazy as B
import Network.HTTP.Conduit (simpleHttp)
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
jsonURL q = "http://api.openweathermap.org/data/2.5/weather?q=" ++ q ++ "&units=metric&appid=e7b9dd9f41c3ac26eae9e94536c8075e"

getJSON :: String -> IO B.ByteString
getJSON town = simpleHttp (jsonURL town)

main :: IO ()
main = do
 putStrLn "Hello! Please insert your town >>> \n "
 town <- getLine
 putStrLn ("Your town is: " ++ town ++ "\n")
 d <- (eitherDecode <$> (getJSON town)) :: IO (Either String Temperatures)
 case d of
  Left e -> putStrLn e
  Right stuff -> putStrLn ("Weather now is: \n" ++ (description (Prelude.head(weather stuff))) ++ "\n\nTempeature now is: " ++ show (temp (test stuff)))
  -- Right stuff -> print (fmap weather stuff)
