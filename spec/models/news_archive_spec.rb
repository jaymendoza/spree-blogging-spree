require 'spec_helper'

describe NewsArchive do
  before(:each) do
    BlogEntry.destroy_all
    5.times { Factory(:blog_entry) }
    @archive = NewsArchive.new
  end

  it "should return all entries" do
    @archive.entries.should == BlogEntry.all
  end

  context "the years array" do
    before(:each) do
      BlogEntry.destroy_all
      5.times { Factory.create(:blog_entry) }
      @archive = NewsArchive.new
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

  context "#find_months_for_year" do
    before(:each) do
      BlogEntry.destroy_all
      5.times { Factory(:blog_entry_months) }
      @archive = NewsArchive.new
      @months = @archive.find_months_for_year(2009)
    end

    it "should return an array" do
      @months.should be_an_instance_of(Array)
    end

    it "should have Fixnum as array elements" do
      @months.each do |month|
        month.should be_an_instance_of(Fixnum)
      end
    end
  end

  context "#years_with_months" do
    before(:each) do
      BlogEntry.destroy_all
      5.times { Factory(:blog_entry_months) }
      @archive = NewsArchive.new
      @years_with_months = @archive.years_with_months
    end

    it "should return a hash" do
      @years_with_months.should be_an_instance_of(Hash)
    end

    it "should return a hash with arrays of Fixnums as its hash values" do
      @years_with_months.values.each do |months|
        months.should be_an_instance_of(Array)

        months.each do |month|
          month.should be_an_instance_of(Fixnum)
        end
      end
    end
  end

  context "#map_entries" do
    context "the returned hash" do
      before(:each) do
        BlogEntry.destroy_all
        5.times { Factory(:blog_entry_months) }
        @archive = NewsArchive.new
        @entries = @archive.map_entries
      end

      it "should be a Hash" do
        @entries.should be_an_instance_of(Hash)
      end

      it "should be a nested Array" do
        @entries.first.should be_an_instance_of(Array)
      end

      it "should have years as first elements" do
        @entries.first[0].to_s.should match /\d{4}/
      end

      it "should return arrays of BlogEntries nested in arrays" do
        blog_entries = @entries.first[1].first[1]
        blog_entries.should be_an_instance_of(Array)
        blog_entries.first.should be_an_instance_of(BlogEntry)
      end
    end
  end

  context "#months_with_entries" do
    before(:each) do
      BlogEntry.destroy_all
      5.times { Factory(:blog_entry_months) }
      @archive = NewsArchive.new
      @months_with_entries = @archive.months_with_entries(2009, @archive.entries.map {|e| e.created_at.month }.uniq)
    end

    it "should return an array" do
      @months_with_entries.should be_an_instance_of(Array)
    end

    it "should return a nested array with month names as its first elements" do
      @months_with_entries.first[0].should be_an_instance_of(String)
    end

    it "should return an array with arrays of BlogEntries" do
      blog_entries = @months_with_entries.first[1]
      blog_entries.should be_an_instance_of(Array)
      blog_entries.first.should be_an_instance_of(BlogEntry)
    end
  end

  context "self.generate" do
    before(:each) do
      BlogEntry.destroy_all
      5.times { Factory(:blog_entry_months) }
      @news_archive = NewsArchive.generate
    end

    it "should return a hash" do
      @news_archive.should be_an_instance_of(Hash)
    end
  end

end
