{-# LANGUAGE DeriveGeneric #-}
module Models where

import GHC.Generics
import Data.Aeson (FromJSON, ToJSON)

data User =
    User { name :: String
         , email :: String
         , phone :: String
         } deriving (Show,Generic)

instance FromJSON User
instance ToJSON User
