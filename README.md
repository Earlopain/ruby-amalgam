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

$ docker compose run amalgam --all -cve "def foo(...) super(...) {} end"
===================1.8===================
ruby 1.8.7 (2013-06-27 patchlevel 374) [x86_64-linux]
-e:1: syntax error, unexpected tDOT3, expecting ')'
def foo(...) super(...) {} end
           ^

===================1.9===================
ruby 1.9.3p551 (2014-11-13 revision 48407) [x86_64-linux]
-e:1: syntax error, unexpected tDOT3, expecting ')'
def foo(...) super(...) {} end
           ^

===================2.0===================
ruby 2.0.0p648 (2015-12-16 revision 53162) [x86_64-linux]
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
           ^

===================2.1===================
ruby 2.1.10p492 (2016-04-01 revision 54464) [x86_64-linux]
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
           ^

===================2.2===================
ruby 2.2.10p489 (2018-03-28 revision 63023) [x86_64-linux]
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
           ^

===================2.3===================
ruby 2.3.8p459 (2018-10-18 revision 65136) [x86_64-linux]
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
           ^

===================2.4===================
ruby 2.4.10p364 (2020-03-31 revision 67879) [x86_64-linux]
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
           ^

===================2.5===================
ruby 2.5.9p229 (2021-04-05 revision 67939) [x86_64-linux]
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
        ^~~

===================2.6===================
ruby 2.6.10p210 (2022-04-12 revision 67958) [x86_64-linux]
-e:1: syntax error, unexpected ..., expecting ')'
def foo(...) super(...) {} end
        ^~~

===================2.7===================
ruby 2.7.8p225 (2023-03-30 revision 1f4d455848) [x86_64-linux]
-e:1: both block arg and actual block given

===================3.0===================
ruby 3.0.7p220 (2024-04-23 revision 724a071175) [x86_64-linux]
-e:1: both block arg and actual block given

===================3.1===================
ruby 3.1.6p260 (2024-05-29 revision a777087be6) [x86_64-linux]
-e:1: both block arg and actual block given

===================3.2===================
ruby 3.2.6 (2024-10-30 revision 63aeb018eb) [x86_64-linux]
-e:1: both block arg and actual block given
-e: compile error (SyntaxError)

===================3.3===================
ruby 3.3.6 (2024-11-05 revision 75015d4c1f) [x86_64-linux]
Syntax OK

===================3.4===================
ruby 3.4.0rc1 (2024-12-12 master 29caae9991) +PRISM [x86_64-linux]
/root/.rbenv/versions/3.4.0-rc1/bin/ruby: -e:1: syntax error found (SyntaxError)
> 1 | def foo(...) super(...) {} end
    |                         ^~ both block arg and actual block given; only one block is allowed
  2 | 
```
