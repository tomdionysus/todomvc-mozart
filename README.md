# TodoMVC Mozart

A TodoMVC example in the [Mozart](http://mozart.io/) Framework.

Please see [The official TodoMVC website](http://todomvc.com/) for more details.

### Dependencies
- [Node.js](http://nodejs.org/)

```
npm install
```

### Run development server

```
grunt run
```

The development server runs at [http://localhost:8080/](http://localhost:8080/)

### Testing

The application can be tested at the command line

```
grunt test
```

The spec runner is also available at [http://localhost:8080/specs/](http://localhost:8080/specs/)

### Caveats

The Mozart LocalStorage places each entity record in a seperate key for speed of access, this is a departure from the TodoMVC application spec which states a single key with a large data blob.
