# TodoMVC Mozart

A TodoMVC example in [Mozart](http://mozart.io/)

### Dependencies
- [Node.js](http://nodejs.org/)
- [GruntJS](http://gruntjs.com/)
- [CoffeeScript](http://coffeescript.org/)
- [SASS](http://sass-lang.com/) (Optional)

### Developing
Once you have installed all of the above software dependencies, you need to install the application dependencies by
running `npm install`. After that,  all you need to do is `grunt run` to compile all of the necessary code, and launch
a static web server through which to view your application. The default address is:
[http://localhost:8080/](http://localhost:8080/)

You can change the web server's port by creating a `config.json` file like this:

```js
{
    "testServer": {
        "port": 8080
    }
}
```

If you cannot install grunt globally, you can run `./node_modules/.bin/grunt run` instead.

You may find it useful to add the following to your shell rc file (e.g., `~/.bashrc` or `~/.zshrc`):

```
PATH=node_modules/.bin:$PATH
```

This way, when you are in a node project with local binaries installed, you can run the binaries without installing them
globally. In this instance, you could just run `grunt run`.

### Testing
This sample project includes [Jasmine](https://github.com/pivotal/jasmine/wiki) and [Sinon](http://sinonjs.org/) to
help you write unit tests for your application. All spec files need to live in the `app/specs/` folder, and be named
with the suffix `-spec`. If you follow these conventions, all new tests that you add will be automatically compiled
via `Grunt`.

The spec runner itself is available at [http://localhost:8080/specs/](http://localhost:8080/specs/)

Your application can also be tested at the command line. One of the installed dependencies is the
[PhantomJS](http://phantomjs.org/) headless browser, which is executed via `Grunt`. To run the unit tests, use `npm
test`.

### Orientation
    app/                -> Where all your core application files live
        assets/         -> Static assets (CSS, images, HTML)
               specs/   -> Various helper libraries for running tests
        config/         -> Core Mozart application files
        controllers/    -> Controllers go here
        lang/           -> i18n files
        models/         -> Models go here
        scss/           -> Where to put your SASS files (optional)
        specs/          -> Your actual unit tests go here
        templates/      -> Handlebars templates for your application
        views/          -> View classes go here
    config/             -> Custom Grunt tasks
    build/              -> Intermediate Mozart build files
    public/             -> Where your built application winds up
    vendor/             -> Various external library dependencies
