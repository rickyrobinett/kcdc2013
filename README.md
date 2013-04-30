Setup
========

Ubuntu:

    > sudo apt-get install haskell-platform

Fedora:

    > sudo yum install haskell-platform

OS X:

    > brew install gnu-sed
    > brew install haskell-platform

Then, on any/all:

    > cabal update
    > cabal install wai-extra
    > cabal install warp
    > cabal install aeson
    > git submodule init
    > git submodule update
    > cp kcdc2013.hs scotty
    > bin/render.sh
    > cd scotty/
    > runghc kcdc2013.hs &

Or compile the binary:

    > ghc -O kcdc2013.hs
    > ./kcdc2013 >> kcdc2013.log &

The binary on Debian, Fedora, and Ubuntu can use POSIX capabilities to run on a privileged port e.g., 80.  Just edit line 10, recompile, and run setcap, like this:

     9 ..
    10 main = scotty 3001 $ do
    11 ..

     9 ..
    10 main = scotty   80 $ do
    11 ..

    > sudo /sbin/setcap 'cap_net_bind_service=ep' ./kcdc2013
    > ./kcdc2013 >> kcdc2013.log &

Notes:

Thanks to Andrew Farmer and ku-fpg for scotty https://github.com/xich and all the great Haskell projects https://github.com/xich https://github.com/ku-fpg
