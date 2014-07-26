{-# LANGUAGE EmptyDataDecls    #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE FlexibleInstances #-}
module Models where

import           Database.Persist
import           Database.Persist.Sqlite
import           Database.Persist.TH
import           Data.Time
import           Control.Monad.Trans.Resource (ResourceT, runResourceT)
import Utils

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
User json
    name String
    email String
    phone String
    deriving Show
Schedule json
    userId Int
    period Int
    start UTCTime
    deriving Show
|]

runDb :: SqlPersistT (ResourceT IO) a -> IO a
runDb query = runResourceT . withSqliteConn "dev.sqlite3" . runSqlConn $ query

readUsers :: IO [Entity User]
readUsers = (runDb $ selectList [] [])
