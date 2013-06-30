/*global module require */

/**
 * Custom task for invoking the Ruby SASS gem.
 */
module.exports = function(grunt){

    var VALID_TYPES = ['controller', 'model', 'template', 'view'];

    // Grab some libraries.
    var fs = require('fs');
    var Handlebars = require('handlebars');
    var underscore = require('underscore.string');

    // Create the task.
    grunt.registerTask('generate', 'Generates various Mozart objects based on templates.', function(type, name, path){

        // Sanitize input.
        type = underscore.clean(type);
        name = underscore.clean(name);
        path = underscore.clean(path);

        // Make sure they provided the necessary parameters.
        if (underscore.isBlank(type) && underscore.isBlank(name)) {
            console.log('Insufficient parameters passed. You must provide a type and a name like so: `grunt generate:model:employee[:path]`. Exiting.');
            return false;
        }

        // Make sure the type was valid.
        if (VALID_TYPES.indexOf(type) < 0) {
            console.log(type + ' is not a valid Mozart component type. Valid types are: ' + VALID_TYPES.join(', ') + '. Aborting.');
            return false;
        }

        // Load the required template file.
        var content = fs.readFileSync(__dirname + '/templates/' + type + '.hbs').toString();

        // Convert the name appropriately.
        name = underscore.underscored(name);

        var sPath="";
        if(path.length>0){sPath=path+"/";}

        // Build an object out of the values.
        var data = {
            Application: grunt.config('generate.name'),
            Name: underscore.classify(name),
            name: name,
            path: sPath
        };

        // Inject the required values into that content.
        var compiler = Handlebars.compile(content);
        content = compiler(data);

        // Figure out where the output is going.
        var folder = grunt.config('generate.root') + type + 's/';

        if(path.length>0){folder+=path+"/";}

        // Make sure it exists.
        try {
            var info = fs.lstatSync(folder);
            if (info.isDirectory()){

                // Generate an appropriate name for the file.
                var filename = folder + name;

                // Figure out which suffix to use.
                var suffix = (type == 'template') ? '_view.hbs' : '_' + type + '.coffee';
                filename += suffix;

                // Make sure that file doesn't already exist.
                if (!fs.existsSync(filename)) {

                    // Save the file to disk.
                    fs.writeFileSync(filename, content);
                    console.log('Created: ' + filename);

                    // If we just created a view, we also need to create a template.
                    // TODO: Externalise this dependency logic.
                    if (type == 'view') {
                        grunt.task.run('generate:template:' + name + ":" + path);
                    }

                    return true;
                }

                else {
                    console.log(filename + ' already exists. Aborting.');
                }
            }

            else {
                console.log(folder + ' is not a directory. Aborting.');
            }
        }
        catch (e) {
            console.log(folder + ' does not exist. Aborting.');
        }

        return false;
    });
};
