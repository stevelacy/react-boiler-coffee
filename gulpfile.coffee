# core
gulp = require 'gulp'
express = require 'express'
# stream utilities
path = require 'path'

# plugins
reload = require 'gulp-livereload'
stylus = require 'gulp-stylus'
# misc
autowatch = require 'gulp-autowatch'

# browserify crap
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
coffeeify = require 'coffeeify'
browserify = require 'browserify'
watchify = require 'watchify'

# paths
paths =
  bundle: './src/index.coffee'
  stylus: './src/index.styl'
  html: './src/index.html'
  img: './src/img/**/*'

# javascript
args =
  fullPaths: true
  debug: true
  cache: {}
  packageCache: {}
  extensions: ['.coffee']

bundler = browserify paths.bundle, args
bundler = watchify bundler
bundler.transform coffeeify

bundle = ->
  bundler.bundle()
    .pipe source 'index.js'
    .pipe buffer()
    .pipe gulp.dest './public'
    .pipe reload()

gulp.task 'js', bundle

gulp.task 'server', (cb) ->
  app = express()
  app.use express.static "#{__dirname}/public"
  app.get '/*', (req, res) ->
    res.sendFile "#{__dirname}/public/index.html"
  app.listen 5000
  cb()

gulp.task 'stylus', ->
  gulp.src paths.stylus
    .pipe stylus()
    .pipe gulp.dest './public'
    .pipe reload()

gulp.task 'html', ->
  gulp.src paths.html
    .pipe gulp.dest './public'
    .pipe reload()

gulp.task 'img', ->
  gulp.src paths.img
    .pipe gulp.dest './public'
    .pipe reload()

gulp.task 'watch', (cb) ->
  reload.listen()
  bundler.on 'update', gulp.parallel 'js'
  autowatch gulp, paths
  cb()

gulp.task 'default', gulp.parallel 'watch', 'js', 'server', 'img', 'html'
