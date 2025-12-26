# Example of Ruby lightweight web frameworks

This project is recently renewed to try Ruby 4.0.

## A rack middleware

Start a rack app witt puma.
```shell
bundle install
export RUBY_OPTS="--enable=zjit,frozen-string-literal" 
bundle exec puma rack/calc_time.ru
```

Then `curl -v http://localhost:9292` to see a response time in the body.
