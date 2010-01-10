BloggingSpree
=========================

Originally forked from paulcc/spree-blog, this extension intends to offer a more complete blogging solution for use within the Spree E-Commerce application.

Development is in its early stages, containing only a simple blog and a jQuery-powered news archive widget. See the current TODO list below.

Dependencies
------------

* Spree 0.9.3*
* is_taggable
* jQuery
* nicEdit _(included)_

_*may run on edge Spree with some modification_

Testing
-------

* RSpec
* factory_girl
* spork

The included spec_helper.rb is configured for use with Spork due to Spree's extended loading time.

Installation
------------

    script/extension install git://github.com/jaymendoza/blogging_spree.git
    rake db:migrate

TODO
----

* <del>Slugs/Pretty URLs</del>
* <del>Month/Year archive pages</del>
  * exist, but need to be hooked up to widget
* <del>Tags</del>
* Comments (?)
