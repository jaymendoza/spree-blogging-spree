require 'spec_helper'

describe NewsArchive do
  before(:each) do
    BlogEntry.destroy_all
    5.times {|i| Factory(:blog_entry, :created_at => Date.new(2010+i)) }
    @news_archive = NewsArchive.new
  end

  describe "the processed set of entry data" do
    it "should be an Array" do
      @news_archive.entries.should be_an_instance_of(Array)
    end

    it "should have years as its root elements" do
      @news_archive.entries.first[0].to_s.should match /\d{4}/
    end

    it "should have nested arrays of BlogEntries" do
      @news_archive.entries.first[1].first[1].first.should be_an_instance_of(BlogEntry)
    end
  end

  describe "the list of years" do
    it "should be an array" do
      @news_archive.years.should be_an_instance_of(Array)
    end

    it "should include 4-digit years" do
      @news_archive.years.first.to_s.should match /\d{4}/
    end

    it "should include only years encompassed in the blog entries" do
      @news_archive.years.should == [2014,2013,2012,2011,2010]
    end
  end

  describe "the list of months with posts for a given year" do
    before(:each) do
      @months = @news_archive.months_for(2010)
    end

    it "should be an array" do
      @months.should be_an_instance_of(Array)
    end

    it "should contain 1 or 2-digit numbers" do
      @months.first.to_s.should match /\d{1,2}/
    end
  end
end
