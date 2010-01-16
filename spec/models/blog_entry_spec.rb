require 'spec_helper.rb'

describe BlogEntry do
  context "finding entries by date" do
    before(:each) do
      @date = Date.new(2009, 3, 11)
      @blog_entry = Factory(:blog_entry, :created_at => @date)
    end

    context "@params is a hash" do
      it "with @params: year" do
        @params = {:year => 2009}
      end

      it "with @params: year and month" do
        @params = {:year => 2009, :month => 3}
      end

      it "with @params: year, month, and day" do
        @params = {:year => 2009, :month => 3, :day => 11}
      end

      after(:each) do
        BlogEntry.by_date(@params).first.should == @blog_entry
      end
    end

    context "@params is an array" do
      it "with @params: date, :month" do
        @params = @date, :month
        BlogEntry.by_date(*@params).first.should == @blog_entry
      end
    end
  end

  describe "News Archive widget" do
    before(:each) do
      BlogEntry.destroy_all
      5.times {|i| Factory(:blog_entry, :created_at => Date.new(2010+i)) }
      @organized_entries = BlogEntry.organize_blog_entries
    end

    describe "the processed set of entry data" do
      it "should be an Array" do
        @organized_entries.should be_an_instance_of(Array)
      end

      it "should have years as its root elements" do
        @organized_entries.first[0].to_s.should match /\d{4}/
      end

      it "should have nested arrays of BlogEntries" do
        @organized_entries.first[1].first[1].first.should be_an_instance_of(BlogEntry)
      end
    end

    describe "the list of years" do
      before(:each) do
        @years = BlogEntry.years
      end

      it "should be an array" do
        @years.should be_an_instance_of(Array)
      end

      it "should include 4-digit years" do
        @years.first.to_s.should match /\d{4}/
      end

      it "should include only years encompassed in the blog entries" do
        @years.should == [2014,2013,2012,2011,2010]
      end
    end

    describe "the list of months with posts for a given year" do
      before(:each) do
        @months = BlogEntry.months_for(2010)
      end

      it "should be an array" do
        @months.should be_an_instance_of(Array)
      end

      it "should contain 1 or 2-digit numbers" do
        @months.first.to_s.should match /\d{1,2}/
      end
    end
  end

end
