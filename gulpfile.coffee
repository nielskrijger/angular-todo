gulp       = require 'gulp'
webserver  = require 'gulp-webserver'
coffee     = require 'gulp-coffee'
bowerFiles = require 'main-bower-files'
bower      = require 'gulp-bower'
bump       = require 'gulp-bump'
clean      = require 'gulp-clean'
sourcemaps = require 'gulp-sourcemaps'
argv       = require('yargs').argv

config =
  path:
    bower: './'
    source: './app'
    dist_js: './www/js'
    dist: './www'

# Runs the webserver
gulp.task 'webserver', ['dist', 'watch'], ->
  gulp.src config.path.dist
  .pipe webserver
    livereload: true
    open: true
    port: 3050

# Runs bower install
gulp.task 'bower-install', ->
  bower cwd: config.path.bower

# Builds the production distributable
gulp.task 'dist', ['clean-dist'], (cb) ->
  gulp.src "#{config.path.source}/**/*.coffee"
  .pipe sourcemaps.init()
  .pipe coffee
    bare: true
  .pipe sourcemaps.write()
  .pipe gulp.dest config.path.dist_js
  cb()

# Cleans up distribution directory
gulp.task 'clean-dist', ->
  gulp.src config.path.dist_js
  .pipe clean {force: true}

# Registers watches for compile and dist
gulp.task 'watch', ->
  gulp.watch "#{config.path.source}/**/*.coffee", ['dist']
