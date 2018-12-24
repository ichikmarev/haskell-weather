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

data DataPoint = DataPoint { description :: String
                           } deriving (Show, Generic)

data Temperatures = Temperatures { weather :: DataPoint
                                 } deriving (Show, Generic)

instance FromJSON Temperatures
instance ToJSON Temperatures
instance FromJSON DataPoint
instance ToJSON DataPoint

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
  Left e -> putStrLn "Error occured. Try again please"
  Right stuff -> print ("Weather now is " ++ (description (weather stuff)))
  -- Right stuff -> print (fmap weather stuff)
