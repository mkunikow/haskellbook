
# Exercises
## Intermission: Check your understanding

Here is the import list from one of the modules in Chris’s library
called blacktip:

```haskell
import qualified Control.Concurrent as CC
import qualified Control.Concurrent.MVar as MV
import qualified Data.ByteString.Char8 as B
import qualified Data.Locator as DL
import qualified Data.Time.Clock.POSIX as PSX
import qualified Filesystem as FS
import qualified Filesystem.Path.CurrentOS as FPC
import qualified Network.Info as NI
import qualified Safe
import Control.Exception (mask, try)
import Control.Monad (forever, when)
import Data.Bits
import Data.Bits.Bitwise (fromListBE)
import Data.List.Split (chunksOf)
import Database.Blacktip.Types
import System.IO.Unsafe (unsafePerformIO)

```

For our purposes right now, it does not matter whether you are
familiar with the modules referenced in the import list. Look at the
declarations and answer the questions below:

1. What functions are being imported from Control.Monad?
Answear:
forever, when
2. Which imports are both unqualified and imported in their en- tirety?
Answear:
```haskell
import Data.Bits
import Database.Blacktip.Types
```

3. From the name, what do you suppose importing Blacktip’s Types module brings in?
Answear: Types?
4. Now let’s compare a small part of blacktip’s code to the above import list:

```haskell
writeTimestamp :: MV.MVar ServerState -> FPC.FilePath -> IO CC.ThreadId
writeTimestamp s path = do
    CC.forkIO go
    where go = forever $ do
        ss <- MV.readMVar s
        mask $ \_ -> do
        FS.writeFile path (B.pack (show (ssTime ss)))
            -- sleep for 1 second
        CC.threadDelay 1000000
```

* a) The type signature refers to three aliased imports. What modules are named in those aliases?
* b) Which import does FS.writeFile refer to?
Answear:
FS -> Filesystem
* c) Which import did forever come from?
Answear:
Comtrol.Monad



