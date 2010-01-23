require 'rubygems'
require 'spork'

Spork.prefork do
  require File.expand_path( File.dirname(__FILE__) + '/../../../../test/test_helper')
  require 'monkeyspecdoc'
  require 'rr'
  require 'webrat'

  class Test::Unit::TestCase
    include Webrat::Matchers
    include RR::Adapters::TestUnit

    def response_body
      @response.body
    end
  end
end

Spork.each_run do
  require File.expand_path(File.dirname(__FILE__) + "/factories")
end

