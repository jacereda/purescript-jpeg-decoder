module Test.Main where

import Prelude
import Control.Monad.Aff (attempt, launchAff)
import Control.Monad.Aff.Console (CONSOLE, log)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Either (Either(..))
import Data.Image.JPEG.Decoder (decode)
import Network.HTTP.Affjax (AJAX, get)

main :: forall e. Eff (exception :: EXCEPTION, ajax :: AJAX, console :: CONSOLE | e) Unit
main = void $ launchAff do
  tst "https://sateuhtoaeuteosua.net/computervision/images/3/34/Lenna.jpg"  
  tst "https://vignette2.wikia.nocookie.net/computervision/images/3/34/Lenna.jpg"
  tst "https://vignette2.wikia.nocookie.net/computervision/foo"
  where tst url = do
          response <- attempt $ get url
          case response of
            Left err -> report err
            Right res -> do
              case decode res.response of
                Left err -> report err
                Right im -> log $ show im.width <> "x" <> show im.height
              pure unit
          pure unit

        report e = log $ "Error : " <> show e
