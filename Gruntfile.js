/*global module */

module.exports = function (grunt) {

    // Load additional modules.
    grunt.loadNpmTasks('grunt-coffeelint');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-handlebars');
    grunt.loadNpmTasks('grunt-contrib-jasmine');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-sass');

    // Load our custom tasks.
    grunt.loadTasks('config/tasks');

    // Define our default lint options.
    var lint = {
        "max_line_length": {
            "level": "ignore"
        },
        "no_trailing_whitespace": {
            "level": "ignore"
        }
    };

    /**
     * Define our Grunt configuration.
     */
    grunt.initConfig({

        clean: {
            build: ["build"],
            public: ["public"],
        },

        /**
         * This task takes care of copy all the files currently found in 'app/assets/' to your 'public' folder.
         * The reasoning behind this is that 'public' should be an entirely disposable folder ala 'target' or 'build'.
         * Subsequent tasks will then populate various folders with their build artefacts.
         */
        copy: {
            assets: {
                files: [{
                    expand: true,
                    cwd: 'app/assets/',
                    src: '**',
                    dest: "public/"
                }]
            }
        },

        /**
         * This task handles compiling all of the necessary CoffeeScript files for your application into a single
         * JavaScript file, that will subsequently be packaged for use.
         *
         * The only convention you must absolutely follow is that 'boot.coffee' must be the first file compiled, and
         * 'app.coffee' must be the last.
         *
         * Due to the way CoffeeScript creates closures, the order files are concatenated together can introduce errors
         * in your application. Essentially, if a given file depends on another (such as a class extending a base
         * class), the base class must appear first in the source, so it can be resolved properly. That is why, in the
         * sample configuration below, top-level Controllers and Views are included first, the  assumption being that
         * child classes are more likely to be nested in folders. If, however, you choose to nest your classes at the
         * same level, beware that you may have to manually specify individual files to ensure correct compilation
         * order.
         */
        coffee: {
            compile: {
                files: {
                    'public/specs/specs.js': [
                        'app/specs/*-spec.coffee',
                        'app/specs/**/*-spec.coffee'
                    ],
                    'build/application.js': [
                        // The boot file needs to come first.
                        'app/config/boot.coffee',

                        // Plugins
                        'app/plugins/*.coffee',
                        'app/plugins/**/*.coffee',

                        // Models.
                        'app/models/*.coffee',

                        // Include the base controllers first, then the classes that extend them.
                        'app/controllers/*.coffee',
                        'app/controllers/steps/*.coffee',

                        // Likewise include the base views first, then the classes that extend them.
                        'app/views/*.coffee',
                        'app/views/**/*.coffee',

                        // The app itself needs to be last.
                        'app/config/app.coffee'
                    ]
                }
            }
        },

        // Define the files we'll lint.
        coffeelint: {
            app: {
                files: {
                    src: ['app/**/*.coffee']
                },
                options: lint
            }
        },

        // Handle concatenating our various files inc plugins.
        concat: {
            vendor: {
                src: [
                  'build/*.js',
                ],
                dest: 'public/js/app.js'
            }
        },

        /**
         * The 'generate' task will automatically generate templates for Controllers, Models, Views and Handlebars
         * templates. Run the task for full instructions.
         */
        generate: {
            name: 'App',
            root: 'app/'
        },

        /**
         * This task handles compiling our Handlebars templates into JavaScript functions that get executed in the
         * browser to generate HTML. We generate these on the server, so the client doesn't have to. We also apply a
         * little bit of tweaking to the generated template name, for Mozart's benefit.
         */
        handlebars: {
            compile: {
                options: {
                    namespace: 'HandlebarsTemplates',
                    processName: function (original) {
                        return original.replace('.hbs', '');
                    },
                    wrapped: true
                },
                files: {
                    'build/templates.js': 'app/templates/**/*.hbs'
                }
            }
        },

        /**
         * This task allows you to run tests from the command line. It does so by invoking the 'PhantomJS' tool, which
         * is installed as a dependency.
         */
        jasmine: {
            src: [
                // Test tools.
                'public/specs/sinon-1.6.0.js',

                // Application content.
                'public/js/app.js',
                'public/i18n/en-US.js'
            ],
            options: {
                helpers: 'public/specs/init.js',
                specs: 'public/specs/specs.js',
                vendor: [
                    'public/js/handlebars-1.0.rc.1.js',
                    'public/js/jquery-1.9.1.js',
                    'public/js/underscore-min.js',
                    'public/js/mozart.min.js',
                ],
                junit: {
                    output: 'public/specs/junit/'
                }
            }
        },

        /**
         * This task provides internationalisation by compiling the JSON files it finds into JavaScript functions that
         * can be referenced in your Handlebars templates using the {{i18n}} helper. The language file that is used
         * is up to you to determine and include. See 'app/assets/index.html' for an example.
         */
        messageformat: {
            app: {
                src: "app/lang",
                dest: "public/js/i18n"
            }
        },

        /**
         * This task handles compiling our SASS files into actual CSS the browser can use. This task is nothing more
         * than a thin wrapper to the regular SASS gem - the point is just to give you a central place you can
         * configure paths, and also bind Watch tasks.
         *
         * If you don't want to use SASS, or want to manage it manually by other means, just remove 'sass' from the
         * 'run' shortcut below, and remove the accompanying 'scss' block from the 'watch' task.
         */
        sass: {
            app: {
                files: {
                    'public/css/app.css': 'app/scss/*'                    
                }
            }
        },

        /**
         * This task fires up a simple Express application, running on the given port and serving files from the given
         * directory. It is useful for stubbing out RESTful functionality etc. Should you wish to expand upon and make
         * changes to the Express app, see 'config/tasks/testserver.coffee'.
         */
        testServer: {
            port: getTestServerPort(),
            base: './public'
        },

        /**
         * The Regarde tasks allows Grunt to run by itself, monitoring your files for changes and automatically updating
         * artefacts and your browser when they occur. You do this by registering a set of files to watch, and a set of
         * tasks to run when those files change.
         */
        watch: {
            app: {
                files: 'app/**/*.coffee',
                tasks: ['coffeelint', 'coffee', 'concat'],
                options: { livereload: 36729 },
            },
            assets: {
                files: 'app/assets/**/*.*',
                tasks: ['copy'],
                options: { livereload: 36729 },
            },
            handlebars: {
                files: 'app/templates/**/*.hbs',
                tasks: ['handlebars' , 'concat'],
                options: { livereload: 36729 },
            },
            messageformat: {
                files: 'app/lang/**/*.json',
                tasks: ['messageformat'],
                options: { livereload: 36729 },
            },
            scss: {
                files: 'app/scss/**/*.scss',
                tasks: ['sass'],
                options: { livereload: 36729 },
            }
        }
    });

    /**
     * Here, we define some convenience tasks for use when invoking Grunt from the command line. Feel free to modify
     * or expand upon these as you see fit.
     */

    /**
     * This task is responsible for copying, compiling and concatenating all the various aspects of your application.
     */
    grunt.registerTask('build', ['clean', 'copy', 'coffee', 'handlebars', 'sass', 'concat', 'messageformat']);

    function getTestServerPort() {
        /**
         * If 'config.json' exists, load its properties. Currently only supports 'testServer.port'.
         */
        if (!grunt.file.exists('config.json')) {
            return 8080;
        }

        var config = grunt.file.readJSON('config.json');

        if (typeof config.testServer == 'undefined' || typeof config.testServer.port == 'undefined') {
            return 8080;
        }

        if (typeof config.testServer.port != 'number') {
            return parseInt(config.testServer.port);
        }

        return config.testServer.port;
    }
    
    /**
     * This task builds your application, then spins up a simple Express server and begins watching your files for
     * changes.
     */
    grunt.registerTask('run', ['build', 'testServer', 'watch']);
    grunt.registerTask('test', ['build', 'jasmine']);
};
