require File.expand_path(File.dirname(__FILE__) + '/../../test/test_helper')

class BlogEntryTest < ActiveSupport::TestCase
  context "with a date and a blog_entry" do
    setup do
      @date = Date.new(2009, 3, 11)
      @blog_entry = Factory(:blog_entry, :created_at => @date)
    end

    context "and potentially incomplete date information" do
      setup do
        @year = {:year => 2009}
        @year_month = {:year => 2009, :month => 3}
        @year_month_day = {:year => 2009, :month => 3, :day => 11}
        @missing_year = {:year => 1999}
        @missing_year_month = {:year => 1999, :month => 6}
        @missing_year_month_day = {:year => 1999, :month => 6, :day => 6}
      end

      should "be able to find matching entries" do
        assert_contains BlogEntry.by_date(@year), @blog_entry
        assert_contains BlogEntry.by_date(@year_month), @blog_entry
        assert_contains BlogEntry.by_date(@year_month_day), @blog_entry

        assert_does_not_contain BlogEntry.by_date(@missing_year), @blog_entry
        assert_does_not_contain BlogEntry.by_date(@missing_year_month), @blog_entry
        assert_does_not_contain BlogEntry.by_date(@missing_year_month_day), @blog_entry
      end
    end

    context "and a type of time period" do
      should "be able to find matching entries" do
        assert_contains BlogEntry.by_date(@date, :year), @blog_entry
        assert_contains BlogEntry.by_date(@date, :month), @blog_entry
        assert_contains BlogEntry.by_date(@date, :day), @blog_entry
      end
    end
  end

  context "with a few blog_entries" do
    setup do
      @first_entry = Factory(:blog_entry, :created_at => Date.new(2010, 1))
      @second_entry = Factory(:blog_entry, :created_at => Date.new(2011, 2))
      @third_entry = Factory(:blog_entry, :created_at => Date.new(2012, 3))
    end

    should "generate data for news archive widget" do
      organized_entries = BlogEntry.organize_blog_entries

      assert organized_entries.is_a?(Hash)

      assert_contains organized_entries.keys, 2010
      assert_contains organized_entries.keys, 2011
      assert_contains organized_entries.keys, 2012

      assert_contains organized_entries[2010][0][1], @first_entry
      assert_contains organized_entries[2011][0][1], @second_entry
      assert_contains organized_entries[2012][0][1], @third_entry
    end

    should "generate a reverse-sorted list of the unique years encompassed by the blog_entries" do
      years = BlogEntry.years

      assert years.is_a?(Array)
      assert_equal [2012, 2011, 2010], years
    end

    should "generate a numeric list of the months that contain blog_entries for a given year" do
      months_one = BlogEntry.months_for(2010)
      months_two = BlogEntry.months_for(2011)
      months_three = BlogEntry.months_for(2012)

      assert months_one.is_a?(Array)
      assert months_two.is_a?(Array)
      assert months_three.is_a?(Array)

      assert_contains months_one, 1
      assert_contains months_two, 2
      assert_contains months_three, 3
    end
  end

  context "with a BlogEntry created late in the day on 2/28/2010" do
    setup do
      Time.zone = 'Eastern Time (US & Canada)'
      @entry = Factory(:blog_entry, :created_at => Time.parse('2010-02-28 21:00:00'))
    end

    should "retrieve given entry when queried for February entries" do
      date = Date.new(2010, 2)
      entries = BlogEntry.by_date(date, :month)
      assert_contains entries, @entry
    end
  end

end
