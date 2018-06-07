module Test.Main where

import Prelude

import Data.ArrayBuffer.ArrayBuffer (byteLength)
import Data.Either (Either(..))
import Data.Image.JPEG.Decoder (decode)
import Effect (Effect)
import Effect.Aff (Aff, attempt, launchAff_)
import Effect.Class.Console (log)
import Network.HTTP.Affjax (get)
import Network.HTTP.Affjax.Response as Response

main :: Effect Unit
main = launchAff_ do
  tst "https://vignette2.wikia.nocookie.net/computervision/images/3/34/Lenna.jpg"
  tst "https://vignette2.wikia.nocookie.net/computervision/foo"
  where tst url = do
          response <- attempt $ get Response.arrayBuffer url
          case response of
             Left err -> report err
             Right res -> do
               case decode res.response of
                 Left err -> report err
                 Right im -> log $ show  im.width <> "x" <> show im.height <> " length:" <> show (byteLength im.data)
               pure unit
          pure unit
        report = log <<< show
