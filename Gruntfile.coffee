module.exports = (grunt) ->

  # load all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    concat:
      min:
        files:
          'public/js/main.js': [
            'public/js/src/libs/*.js',
            'public/js/src/*.js'
          ]

    uglify:
      min:
        files:
          'public/js/main.js': [
            'public/js/src/libs/*.js',
            'public/js/src/*.js'
          ]

    compass:
      dist:
        options:
          config: 'public/css/config.rb'
          sassDir: 'public/css/sass'
          imagesDir: 'public/img'
          cssDir: 'public/css'
          environment: 'production'
          outputStyle: 'compressed'
          force: true

    browserSync:
      files:
        src: 'public/css/screen.css'
      options:
          host: "localhost"
          watchTask: true

    watch:
      options:
        livereload: true
      scripts:
        files: ['public/js/src/*.js','public/js/src/libs/*.js']
        tasks: ['uglify']
      styles:
        files: ['public/css/**/*.{sass,scss}','public/img/ui/*.png']
        tasks: ['compass']

  # Development task checks and concatenates JS, compiles SASS preserving comments and nesting, runs dev server, and starts watch
  grunt.registerTask 'dev', ['compass', 'concat']
  grunt.registerTask 'default', ['compass', 'uglify', 'browserSync', 'watch']
