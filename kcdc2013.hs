{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Network.HTTP.Types (status200)
import Network.Wai.Middleware.Gzip (gzip, def, gzipFiles, GzipFiles( GzipCompress ))
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static

main :: IO ()
main = scotty 3001 $ do

    middleware $ gzip def { gzipFiles = GzipCompress }
    middleware logStdoutDev
    middleware $ staticPolicy (addBase "../assets/static")

    get (regex "^/(index\\.html{0,1}){0,1}$") $ do
      header "Content-type" "text/html"
      status status200
      file "index.html"
