module Clafer (plugin) where

import Network.Gitit.Interface
import System.Process (readProcessWithExitCode)
import System.Exit (ExitCode(ExitSuccess))
-- from the utf8-string package on HackageDB:
import Data.ByteString.Lazy.UTF8 (fromString)
-- from the SHA package on HackageDB:
import Data.Digest.Pure.SHA (sha1, showDigest)
import System.FilePath ((</>))
import Control.Monad.Trans (liftIO)

plugin :: Plugin
plugin = mkPageTransformM claferCompile

claferCompile :: Block -> PluginM Block
claferCompile (CodeBlock (id, classes, namevals) contents) | first classes == "clafer" = do
  let (name, outfile) =  case lookup "name" namevals of
                                Just fn   -> ([Str fn], fn ++ ".cfr")
                                Nothing   -> ([], uniqueName contents ++ ".cfr")
  let filepath = "static/clafer/" ++ outfile
  liftIO $ do
    _ <- writeFile filepath contents
    (ec, out, err) <- readProcessWithExitCode "clafer" ("-o":"-s":(flagTrans (tail classes) filepath)) []
    if ec == ExitSuccess
       then return $ CodeBlock (id, classes, namevals) out
       else error $ "clafer returned an error status: " ++ err-- ++ "\nParameters: " ++ (foldr (\(x) -> ((x ++ ",") ++)) [] (flagTrans (tail classes) filepath))
claferCompile x = return x

--this is added so that it won't break if the wiki contains code blocks with no headers
first [] = []
first (x:xs) = x

-- generate a unique filename based on the file's contents
uniqueName :: String -> String
uniqueName = showDigest . sha1 . fromString

-- translates the tags in the code block into the corresponding clafer tags. Unfortunately, character that are not alphanumeric, and in the attributes, break the code block.
flagTrans :: [String] -> String -> [String]
flagTrans [] y = [y]
flagTrans ("k":xs) y = "-k" : flagTrans xs y
flagTrans ("keepunused":xs) y = "-k" : flagTrans xs y
flagTrans ("malloy":xs) y = "-m=alloy" : flagTrans xs y
flagTrans ("modealloy":xs) y = "-m=alloy" : flagTrans xs y
flagTrans ("malloy42":xs) y = "-m=alloy42" : flagTrans xs y
flagTrans ("modealloy42":xs) y = "-m=alloy42" : flagTrans xs y
flagTrans ("mxml":xs) y = "-m=xml" : flagTrans xs y
flagTrans ("modexml":xs) y = "-m=xml" : flagTrans xs y
flagTrans ("mclafer":xs) y = "-m=clafer" : flagTrans xs y
flagTrans ("modeclafer":xs) y = "-m=clafer" : flagTrans xs y
flagTrans ("v":xs) y = "-v" : flagTrans xs y
flagTrans ("validate":xs) y = "-v" : flagTrans xs y
flagTrans (x:xs) y = flagTrans xs y