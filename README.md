# Ruby Amalgam

One docker image to run many Ruby versions. Similar to [ruby/all-ruby](https://github.com/ruby/all-ruby) but
doesn't contain literally every Ruby version.

## How to use

```bash
$ docker compose build
$ docker compose run amalgam
Usage: docker compose run amalgam [options] [ruby_options]
        --all
        --start VERSION
        --stop VERSION
        --only VERSION

$ docker compose run amalgam --all -ce "def foo(...) super(...) {} end"
===============1.8.7-p374================
-e:1: syntax error, unexpected tDOT3, expecting ')'
def foo(...) super(...) {} end
           ^

===============1.9.3-p551================
-e:1: syntax error, unexpected tDOT3, expecting ')'
def foo(...) super(...) {} end
           ^

===============2.0.0-p648================
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
           ^

=================2.1.10==================
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
           ^

=================2.2.10==================
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
           ^

==================2.3.8==================
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
           ^

=================2.4.10==================
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
           ^

==================2.5.9==================
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
        ^~~

=================2.6.10==================
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
        ^~~

==================2.7.8==================
-e:1: both block arg and actual block given

==================3.0.7==================
-e:1: both block arg and actual block given

==================3.1.6==================
-e:1: both block arg and actual block given

==================3.2.6==================
-e:1: both block arg and actual block given
-e: compile error (SyntaxError)

==================3.3.6==================
Syntax OK

================3.4.0-rc1================
/root/.rbenv/versions/3.4.0-rc1/bin/ruby: -e:1: syntax error found (SyntaxError)
> 1 | def foo(...) super(...) {} end
    |                         ^~ both block arg and actual block given; only one block is allowed
  2 | 
```
