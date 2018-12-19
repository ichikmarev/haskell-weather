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

data DataPoint = DataPoint { id :: Int
                           , description :: String
                           , icon :: String
                           } deriving (Show, Generic)

data Temperatures = Temperatures { weather :: [DataPoint]
                                 } deriving (Show, Generic)

instance FromJSON Temperatures
instance ToJSON Temperatures
instance FromJSON DataPoint
instance ToJSON DataPoint

jsonURL :: String
jsonURL = "http://api.openweathermap.org/data/2.5/weather?id=2172797&appid=e7b9dd9f41c3ac26eae9e94536c8075e"

getJSON :: IO B.ByteString
getJSON = simpleHttp jsonURL


main :: IO ()
main = do
 d <- (eitherDecode <$> getJSON) :: IO (Either String Temperatures)
 case d of
  Left e   -> putStrLn e
  Right stuff -> print stuff
