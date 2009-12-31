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

  context "#find_months_for_year" do
    before(:each) do
      @archive = NewsArchive.new
      @months = @archive.find_months_for_year(2001)
    end

    it "should return an array" do
      @months.should be_an_instance_of(Array)
    end

    it "should have Strings as array elements" do
      @months.each do |month|
        month.should be_an_instance_of(String)
      end
    end
  end

  context "#years_with_months" do
    context "its return value" do
      before(:each) do
        @archive = NewsArchive.new
        @archive.find_years
        @years_with_months = @archive.years_with_months
      end

      it "should be a hash" do
        @years_with_months.should be_an_instance_of(Hash)
      end

      # TODO: figure out what to do re: months as Strings or Fixnums
      # (i.e. December or 12)
      it "should have arrays of Strings as its hash values" do
        @years_with_months.values.each do |months|
          months.should be_an_instance_of(Array)

          months.each do |month|
            month.should be_an_instance_of(Fixnum)
          end
        end
      end
    end
  end

end
