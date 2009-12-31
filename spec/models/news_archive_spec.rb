require 'spec_helper'

describe NewsArchive do
  before(:each) do
    5.times { Factory(:blog_entry) }
    @archive = NewsArchive.new
  end

  it "should return all entries" do
    @archive.entries.should == BlogEntry.all
  end

  context "the years array" do
    before(:each) do
      5.times { Factory.create(:blog_entry) }
      @archive = NewsArchive.new
      @archive.find_years
    end

    it "should be an array" do
      @archive.years.should be_an_instance_of(Array)
    end

    it "should include 4-digit years" do
      @archive.years.each do |year|
        year.to_s.should match /\d{4}/
      end
    end

    it "should include only years encompassed by the blog entries" do
      years = BlogEntry.all.map {|e| e.created_at.year }.uniq
      @archive.years.each do |year|
        years.should include year
      end
    end
  end

end
