module Utils where

import Control.Monad.Logger (MonadLogger, monadLoggerLog)
import Control.Applicative  (pure)

instance MonadLogger IO where
    monadLoggerLog _ _ _ = pure $ pure ()
