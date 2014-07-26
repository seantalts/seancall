{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}


import Web.Scotty
import Control.Applicative
import Control.Monad

import Models

main = scotty 3000 $ do
  get "/" $ do
    json [(0::Int)..10]
  get "/users" $ do
    json User {name="Sean", email="sean@sean", phone="434.713.0499"}
