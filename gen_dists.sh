#!/bin/bash
{
  cd "${BASH_SOURCE%/*}" || exit
  mkdir -p dist/js dist/css

  jade views/index.jade --out dist/

  coffee -c lib/*.coffee
  minify lib/tic_tac_toe_api.js lib/game.js lib/game_prompt.js lib/game_view.js lib/main.js --output dist/js/tttapp.js
  sed -i.bak "1,5d" dist/js/tttapp.js
  rm lib/*.js dist/js/*.bak

  minify public/stylesheets/style.css --output dist/css/style.css
} > /dev/null
