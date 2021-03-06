{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RankNTypes #-}

module Types (
    Config (..),
    RunConfig (..),
    Game (..),
    Sbu,
    Logger,
    Output (..),
) where

import Control.Monad.Reader (ReaderT)
import Data.Serialize (Serialize)
import GHC.Generics (Generic)
import Pipes (Producer')

type Sbu = ReaderT RunConfig IO (Maybe Config)

data Output = Normal String | Info String | Warning String | Error String
    deriving (Show, Eq)

type Logger m a = Producer' Output m a

data RunConfig = RunConfig
    { runConfigConfig :: Config
    , runConfigVerbose :: Bool
    }

data Config = Config
    { configBackupDir :: FilePath
    , configBackupFreq :: Integer
    , configBackupsToKeep :: Integer
    , configGames :: [Game]
    }
    deriving (Show, Generic, Eq)

data Game = Game
    { gameName :: String
    , gamePath :: FilePath
    , gameGlob :: String
    }
    deriving (Show, Generic, Eq)

instance Serialize Config
instance Serialize Game
