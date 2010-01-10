require 'spec_helper'

describe BlogEntriesController do
  before(:each) do
    BlogEntry.destroy_all
    @year, @month, @day = 2009, 3, 11
    NewsArchive.stub!(:new, :return => [])
    @blog_entry = Factory(:blog_entry, :created_at => Date.new(@year, @month, @day))
    @blog_entries = [@blog_entry]
  end

  describe "GET archive" do
    it "should find entries for a year given a year" do
      BlogEntry.should_receive(:by_date).and_return(@blog_entries)
      get :archive, {:year => @year }
    end
  end

  describe "GET /blog/:year/:month:/:day/:slug" do
    it "should route entry permalinks" do
      route_for(
        :controller => 'blog_entries', :action => 'show',
        :year => '2010', :month => '1', :day => '10',
        :slug => 'a-blog-entry'
      ).
      should == 'blog/2010/1/10/a-blog-entry'
    end

    it "should work with entry_permalink_path" do
      d = @blog_entry.created_at
      entry_permalink_path(
        :year => d.year, :month => d.month, :day => d.day,
        :slug => @blog_entry.permalink
      ).should == "/blog/#{d.year}/#{d.month}/#{d.day}/#{@blog_entry.permalink}"
    end
  end
end
