path = require 'path'
gulp = require 'gulp'
coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'
jade = require 'gulp-jade'
reload = require 'gulp-livereload'
awatch = require 'gulp-autowatch'

paths =
  coffee: './client/pages/**/js/*.coffee'
  jade: './client/pages/**/html/*.jade'
  stylus: './client/css/*.styl'
  public: './public'

gulp.task 'server', (cb) ->
  require './server'

gulp.task 'coffee', ->
  gulp.src paths.coffee
  .pipe coffee()
  .pipe gulp.dest paths.public
  .pipe reload()

gulp.task 'jade', ->
  gulp.src paths.jade
  .pipe jade()
  .pipe gulp.dest paths.public
  .pipe reload()

gulp.task 'stylus', ->
  gulp.src paths.stylus
  .pipe stylus()
  .pipe gulp.dest paths.public
  .pipe reload()

gulp.task 'watch', ->
  awatch gulp, paths

gulp.task 'default', ['coffee', 'jade', 'stylus', 'server', 'watch']