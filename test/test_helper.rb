require 'rubygems'
require 'spork'

# Loading more in this block will cause your tests to run faster. However,
# if you change any configuration or code from libraries loaded here, you'll
# need to restart spork for it take effect.
Spork.prefork do
  require File.expand_path( File.dirname(__FILE__) + '/../../../../test/test_helper')

  # require 'monkeyspecdoc'
  # require 'mocha'
end

# This code will be run each time you run your specs.
Spork.each_run do
  require File.expand_path(File.dirname(__FILE__) + "/factories")
end

