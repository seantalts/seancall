{-# LANGUAGE OverloadedStrings #-}


import Web.Scotty
import Control.Monad.IO.Class  (liftIO)
import Models
import Utils
import Database.Persist.Sqlite (runMigration, insert)
import Control.Applicative
import Data.Aeson (eitherDecode)
import qualified Data.ByteString.Lazy as B

main = do
  runDb $ runMigration migrateAll
  scotty 3000 $ do
    get "/" $
      json [(0::Int)..10]
    get "/users" $ do
      _users <- liftIO readUsers
      json _users
    post "/users" $ do
      u <- jsonData :: ActionM User
      liftIO $ runDb $ insert u
      json u