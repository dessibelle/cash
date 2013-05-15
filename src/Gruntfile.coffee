module.exports = (grunt) ->

    # Project configuration.
    grunt.initConfig
        pkg: grunt.file.readJSON('package.json'),

        clean: ["build"]

        coffee:
            main:
                files:
                    'build/js/app.js': ['coffee/app.coffee']

        less:
            main:
                options:
                    paths: ["less", "<%= bootstrap %>/less/"],
                    yuicompress: true
                files:
                    "build/css/main.min.css" : "less/main.less"

        uglify:
            options:
                banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %>\n' +
                        ' * <%= pkg.website %>/\n' +
                        ' * Copyright (c) <%= grunt.template.today("yyyy") %> ' +
                        '<%= pkg.author %>; <%= pkg.license %> */\n'

            main:
                files: [
                    'build/js/modernizr-2.6.2.min.js': ['<%= h5bp %>/js/vendor/modernizr-2.6.2.min.js'],
                    'build/js/jquery-1.9.1.min.js': ['<%= h5bp %>/js/vendor/jquery-1.9.1.min.js'],
                    'build/js/main.min.js': [#'<%= bootstrap %>/jquery-1.9.1.js',
                        # '<%= bootstrap %>/js/bootstrap-button.js',
                        # '<%= bootstrap %>/js/bootstrap-collapse.js',
                        # '<%= bootstrap %>/js/bootstrap-dropdown.js',
                        # '<%= bootstrap %>/js/bootstrap-tooltip.js',
                        # '<%= bootstrap %>/js/bootstrap-popover.js',
                        'build/js/app.js'],

                    # 'build/js/person-show.min.js': ['build/js/person-show.js'],
                    # 'build/js/fields-list.min.js': ['libs/jquery.tablednd.0.9.rc1.js','build/js/fields-list.js'],
                    # 'build/js/import.min.js': ['libs/FileAPI/lib/FileAPI.core.js', 'libs/FileAPI/lib/FileAPI.XHR.js', 'libs/FileAPI/lib/FileAPI.Form.js', 'libs/FileAPI/lib/FileAPI.Image.js', 'build/js/import.js'],
                    # 'build/js/import-assign.min.js': ['build/js/import-assign.js'],
                ]

        copy:
            main:
                files: [
                    { expand: true, flatten: true, src: ['<%= bootstrap %>/img/**'], dest: 'build/img', filter : 'isFile' },
                    { expand: true, cwd: 'build', src: ['**'], dest: '../public_html' },
                ]

        watch:
            watch:
                files: ['coffee/*.coffee', 'js/*.js', 'less/**'],
                tasks: ['default'],
                options:
                    nospawn: true

        bootstrap: '../external/bootstrap'

        h5bp: '../external/html5-boilerplate'


    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-coffee');

    grunt.registerTask('default', ['clean', 'coffee', 'less', 'uglify', 'copy'])
