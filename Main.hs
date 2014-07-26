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
    get "/" $ do
      json [(0::Int)..10]
    get "/users" $ do
      json User {userName="Sean", userEmail="sean@sean", userPhone="434.713.0499"}
    post "/users" $ do
      u <- jsonData :: ActionM User
      liftIO $ runDb $ insert u
      json $ u