require 'spec_helper'

describe BlogEntriesController, "finding blog entries" do
  it "should find a post given a year, month, day and slug" do
    year, month, day = 2009, 3, 11
    NewsArchive.stub!(:new, :return => [])
    @blog_entry = Factory(:blog_entry, :created_at => Date.new(year, month, day))
    @blog_entries = [@blog_entry]

    BlogEntry.should_receive(:by_date).and_return(@blog_entries)
    @blog_entries.should_receive(:detect).and_return(@blog_entry)

    get :archive, {:year => year, :month => month, :day => day, :slug => "a-blog-entry-title"}
  end
end
