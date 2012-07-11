module ClaferCompiler (plugin) where

import Network.Gitit.Interface
import System.Directory (doesFileExist, removeFile)
import Control.Monad.Trans (liftIO)
-- from the utf8-string package on HackageDB:
import Data.ByteString.Lazy.UTF8 (fromString)
-- from the SHA package on HackageDB:
import Data.Digest.Pure.SHA (sha1, showDigest)
import Language.Clafer (generateHtml, compileM, addModuleFragment, defaultClaferArgs,
                        CompilerResult(..))
import Language.Clafer.ClaferArgs
-- import Data.List (intercalate)

plugin :: Plugin
plugin = mkPageTransformM callClafer

callClafer :: Block -> PluginM Block
callClafer (CodeBlock (id, classes, namevals) contents)
  | first classes == "clafer" = liftIO $ do
  notCompiled <- doesFileExist "static/clafer/temp.txt"
  if notCompiled
     then do compile "static/clafer/temp.txt" defaultClaferArgs{mode=Just Html, keep_unused=Just True}
             return (CodeBlock (id, classes, namevals) contents)
     else return (CodeBlock (id, classes, namevals) contents)
callClafer x = return x

compile file args = do
  content <- readFile file
  let CompilerResult {extension = ext,
                      outputCode = output,
                      statistics = stats} = generateHtml args (addModuleFragment args content);
      name = uniqueName content
  writeFile ("static/clafer/" ++ name ++ "." ++ ext)
            ("<head><link rel=\"stylesheet\" type=\"text/css\" href=\"../css/custom.css\" /></head>\n" ++ output)
  writeFile "static/clafer/output.txt" content
  writeFile "static/clafer/name.txt" name
  writeFile ("static/clafer/" ++ name ++ ".cfr") content
  removeFile file

-- this is added so that it won't break if the wiki contains code blocks with no headers
first [] = []
first (x:xs) = x

-- | Generate a unique filename given the file's contents.
uniqueName :: String -> String
uniqueName = showDigest . sha1 . fromString


