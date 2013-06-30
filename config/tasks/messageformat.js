var MessageFormat = require('messageformat'),
    vm = require('vm'),
    path = require('path');

// Language Tags should be RFC4646
// i.e. Hyphens not underscores, lang in lowercase, country in UPPERCASE, region in CapsCase

module.exports = function (grunt) {
    var defaultLocale = "en_US",
        localeMatcher = /^(.+)\.(.+)\.json$/;

    grunt.registerMultiTask("messageformat", "Compiles MessageFormat JSON objects to JS", function () {
        var locales = {};
        var opts = this.data;
        grunt.file.recurse(opts.src, function scanPath (abspath, rootdir, subdir, filename) {
            grunt.log.write('Reading JSON "' + abspath + '"...');

            filename = filename.replace('_','-');

            var name, namespace, locale,
                parts = filename.match(localeMatcher);

            if (parts === null) {
                grunt.log.writeln("SKIPPED");
                return;
            }

            name = parts[1];
            namespace = subdir ? subdir + '/' + name : name;
            locale = (parts[2] || defaultLocale);

            locales[locale] = locales[locale] || {};
            locales[locale][namespace] = grunt.file.readJSON(abspath);
            grunt.log.ok();
        });

        // For each locale, generate a string of the compiled messageformat function
        Object.keys(locales).forEach(function(locale) {
            grunt.log.write("Compiling " + locale + " locale...");
            // lang root is always the first element before the dash
            lang = locale.split('-')[0]
            
            // Attach the language-specific plural forms to the MessageFormat object, prior to compiling
            var localeJsPath = path.join(
                path.dirname(require.resolve('messageformat')),
                'locale',
                lang+'.js'
            );

            var src = grunt.file.read(localeJsPath, { encoding: "utf8" });
            vm.runInNewContext(src, { MessageFormat: MessageFormat });

            var mf = new MessageFormat(locale);

            // Join all the compile functions within in namespace
            var compiledString = Object.keys(locales[locale]).reduce(function (acc, namespace) {

                // Attach each compiled function to the namespace object
                return acc + Object.keys(locales[locale][namespace]).reduce(function (acc2, key) {

                    // compile each MessageFormat string to JS
                    return acc2 + ";window.i18n['" + namespace + "']['" + key + "']=" + mf.precompile(mf.parse(locales[locale][namespace][key]));

                }, ";window.i18n['" + namespace + "']={};");
            }, "(function(){window.i18n={};var MessageFormat={locale:{}};" + src) + "})();";
            grunt.log.ok();

            grunt.log.write("Writing " + locale + " locale to " + opts.dest + "/" + locale + ".js...");
            grunt.file.write(
                path.resolve(opts.dest, locale + ".js"),
                compiledString
            );
            grunt.log.ok();
        });
    });
};