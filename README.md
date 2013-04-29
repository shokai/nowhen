nowhen
======
Tagger for Life Log


Installation
------------

    % gem install nowhen


Usage
-----

    % now --help

log

    % now yummy
    % now -log http://example.com/food

search

    % when yummy
    % when yummy --all


Test
----

    % gem install bundler
    % bundle install
    % bin/now todo
    % bin/when todo

change DB path

    % export NOWHEN_DB=./tmp/db


Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
