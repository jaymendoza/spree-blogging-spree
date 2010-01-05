require 'spec_helper.rb'

describe BlogEntry do
  describe "finding entries by date" do
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
end
