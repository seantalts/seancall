{-# LANGUAGE OverloadedStrings #-}


import Web.Scotty as S
import Control.Monad.IO.Class  (liftIO)
import Models
import Utils
import Database.Persist.Sqlite (runMigration, insert)
import Control.Applicative
import Data.Aeson (eitherDecode)
import qualified Data.ByteString.Lazy as B
import Twilio.Calls as Calls
import Twilio.Types as TwilTypes

main = do
  runDb $ runMigration migrateAll
  scotty 3000 $ do
    S.get "/" $
      json [(0::Int)..10]
    S.get "/users" $ do
      _users <- liftIO readUsers
      json _users
    S.post "/users" $ do
      u <- jsonData :: ActionM User
      liftIO $ runDb $ insert u
      json u