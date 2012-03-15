# Goodfilms Ruby deb package builder

Use vagrant to build whatever version of Ruby you like and chuck it in a deb package.

Script was inspired by [jtimberman's blog post](http://jtimberman.posterous.com/debianubuntu-package-for-ruby-192-with-fpm) but with a fair amount of modifications.

## How now brown cow?

  Clone the repo, install [vagrant](http://vagrantup.com)

    vagrant up
    vagrant ssh

    cd /vagrant && ./package-ruby.sh

  Then you can copy your .deb file out of the repo root

## Credits

Copyright &copy; 2012 Goodfilms. First hax [John Barton](http://github.com/joho). Released under an MIT Licence.
