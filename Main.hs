{-# LANGUAGE GADTs #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Main where

import Clay hiding (s, style, type_)
import qualified Clay as C
import Development.Shake
import Lucid
-- TODO: Don't expose every module
import qualified Neuron.Zettelkasten as Z
import qualified Neuron.Zettelkasten.Config as Z
import qualified Neuron.Zettelkasten.Route as Z
import qualified Neuron.Zettelkasten.View as Z
import Path
import Relude
import qualified Rib
import Rib (IsRoute)
import Rib.Extra.CSS (googleFonts, stylesheet)

data Route a where
  Route_Zettel :: Z.Route s g () -> Route (s, g)
  -- | Redirect to an URL
  Route_Redirect :: Path Rel File -> Route Text

instance IsRoute Route where
  routeFile = \case
    Route_Zettel r ->
      Rib.routeFile r
    Route_Redirect fp ->
      pure fp

main :: IO ()
main = Z.run generateSite

generateSite :: Action ()
generateSite = do
  Rib.buildStaticFiles [[relfile|static/**|]]
  config <- Z.getConfig
  let writeHtmlRoute :: Route a -> a -> Action ()
      writeHtmlRoute r = Rib.writeRoute r . Lucid.renderText . renderPage config r
  void $ Z.generateSite (writeHtmlRoute . Route_Zettel) [[relfile|*.md|]]
  forM_ oldLinkRedirects $ \(oldPath, newUrlRel) ->
    writeHtmlRoute (Route_Redirect oldPath) newUrlRel
  where
    oldLinkRedirects =
      [ ([relfile|tidbits/dhall-toml-free-monad.html|], "/2002201.html"),
        ([relfile|haskell-nix.html|], "/1948201.html"),
        ([relfile|lasik.html|], "/1911401.html"),
        ([relfile|conflicts.html|], "/1930301.html"),
        ([relfile|calisthenics.html|], "/1915701.html"),
        ([relfile|carnivore-diet.html|], "/1918401.html"),
        ([relfile|sous-vide.html|], "/1919301.html")
      ]

renderPage :: Z.Config -> Route a -> a -> Html ()
renderPage site route val = html_ [lang_ "en"] $ do
  head_ @(Html ()) $ do
    case route of
      Route_Redirect _ -> do
        meta_ [httpEquiv_ "Refresh", content_ $ "0; url=" <> val]
      Route_Zettel zr -> do
        Z.renderRouteHead site zr (fst val)
        stylesheet "https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css"
        stylesheet "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css"
        style_ [type_ "text/css"] $ C.render style
        googleFonts $ [headerFont, bodyFont, monoFont]
  body_ $ do
    div_ [class_ "ui text container", id_ "thesite"] $
      case route of
        Route_Zettel r ->
          Z.renderRouteBody site r val
        Route_Redirect _ ->
          mempty

headerFont :: Text
headerFont = "Oswald"

bodyFont :: Text
bodyFont = "Open Sans"

monoFont :: Text
monoFont = "Roboto Mono"

style :: Css
style = "div#thesite" ? do
  C.fontFamily [bodyFont] [C.serif]
  C.paddingTop $ em 1
  C.paddingBottom $ em 1
  "p" ? do
    C.lineHeight $ pct 150
  "h1, h2, h3, h4, h5, h6, .ui.header" ? do
    C.fontFamily [headerFont] [C.sansSerif]
  "img" ? do
    C.maxWidth $ pct 50
    C.display C.block
    C.marginLeft C.auto
    C.marginRight C.auto
  Z.style
