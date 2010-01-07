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
end
