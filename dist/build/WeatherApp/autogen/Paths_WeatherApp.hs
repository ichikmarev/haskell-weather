{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_WeatherApp (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/thesoulofthetime/.cabal/bin"
libdir     = "/Users/thesoulofthetime/.cabal/lib/x86_64-osx-ghc-8.4.3/WeatherApp-0.1.0.0-B1qmizdwVzr1lGbsS1P2JV-WeatherApp"
dynlibdir  = "/Users/thesoulofthetime/.cabal/lib/x86_64-osx-ghc-8.4.3"
datadir    = "/Users/thesoulofthetime/.cabal/share/x86_64-osx-ghc-8.4.3/WeatherApp-0.1.0.0"
libexecdir = "/Users/thesoulofthetime/.cabal/libexec/x86_64-osx-ghc-8.4.3/WeatherApp-0.1.0.0"
sysconfdir = "/Users/thesoulofthetime/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "WeatherApp_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "WeatherApp_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "WeatherApp_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "WeatherApp_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "WeatherApp_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "WeatherApp_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
