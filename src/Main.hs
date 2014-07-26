{-# LANGUAGE OverloadedStrings #-}


import Web.Scotty
import Control.Monad.IO.Class  (liftIO)
import Models
import Utils
import Database.Persist.Sqlite (runMigration)
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
      b <- (eitherDecode <$> body :: IO B.ByteString) :: IO (Either String [User])
      case b of
        Left err -> putStrLn err
        Right ps -> print ps
      
