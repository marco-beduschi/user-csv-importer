# README

## Instalation

### Requirement

- sqlite3
- ruby 3.2.3

```sh
bundle install

bin/rails db:create
bin/rails db:migrate
```

## Development

```sh
bin/rails s
```

### Testing

```sh
bin/rails test:all
```

## Production

Note: It might take 30s for the page to load at first because I'm using
a free tier on Render that puts the server to 'sleep' while inactive.

https://user-csv-importer.onrender.com/
