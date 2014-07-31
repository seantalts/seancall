module Email where

import Text.ParserCombinators.Parsec

data Message = Message { from :: String
                       , to :: String
                       , subject :: String
                       , body :: String
} deriving (Show)


parseEmail :: String -> Either ParseError Message
parseEmail = undefined