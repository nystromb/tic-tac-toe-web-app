#!/bin/bash
{
  cd "${BASH_SOURCE%/*}" || exit
  mkdir -p dist/javascripts dist/stylesheets

  jade views/index.jade --out dist/

  coffee -c lib/*.coffee
  minify lib/tic_tac_toe_api.js lib/game.js lib/game_prompt.js lib/game_view.js lib/main.js --output dist/javascripts/tttapp.js
  sed -i.bak "1,5d" dist/javascripts/tttapp.js
  rm lib/*.js dist/javascripts/*.bak

  minify public/stylesheets/style.css --output dist/stylesheets/style.css
} > /dev/null
