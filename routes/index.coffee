express = require "express"
router = express.Router()

router.get "/", (req, res, next) ->
  res.render "index",
    title: "Totally Tactical Tic Tac Toe"

module.exports = router
