[BloggingSpree](http://github.com/jaymendoza/spree-blogging-spree/)
---------------

Originally forked from [paulcc/spree-blog](http://github.com/paulcc/spree-blog/), this extension intends to offer a more complete blogging solution for use within the Spree E-Commerce application. It currently consists of a blog, news archive, and a news archive widget written in jQuery.

See the [issue tracker](http://github.com/jaymendoza/spree-blogging-spree/issues) for future plans.


Installation
------------

    script/extension install git://github.com/jaymendoza/spree-blogging-spree.git
    sudo rake gems:install
    rake db:migrate


Compatibility
-------------

* Spree 0.9.99 (edge)


Dependencies
------------

* is_taggable
* jQuery
* nicEdit *(included)*


Testing
-------

* shoulda
* factory_girl
* Spork

The included spec_helper.rb is configured for use with Spork due to Spree's extended loading time.

Following the lead of the Spree development team, all tests have been converted to shoulda from RSpec.
