require File.expand_path(File.dirname(__FILE__) + '/../../test/test_helper')

class BlogEntriesControllerTest < ActionController::TestCase
  context "with a blog_entry and its date" do
    setup do
      @blog_entry = Factory(:blog_entry, :created_at => Date.new(2020, 3, 11))
    end

    should "route entry permalinks" do
      route = {:controller => 'blog_entries',
               :action     => 'show',
               :year       => '2020',
               :month      => '3',
               :day        => '11',
               :slug       => 'a-blog-entry'}

      assert_recognizes(route, "/blog/2020/3/11/a-blog-entry")

      path = {:year  => '2020',
              :month => '3',
              :day   => '11',
              :slug  => @blog_entry.permalink}

      assert_equal entry_permalink_path(path),
                   "/blog/2020/3/11/#{@blog_entry.permalink}"
    end
  end

#   context "on GET to archive with a year" do
#     setup do
#       BlogEntry.destroy_all
#       Factory(:blog_entry, :created_at => Date.new(2020, 1))
#       Factory(:blog_entry, :created_at => Date.new(2020, 2))
#       Factory(:blog_entry, :created_at => Date.new(2020, 3))
#       @blog_entries = BlogEntry.all
#     end
#
#     should "find entries for the given year" do
#       controller.class.skip_before_filter :load_news_archive_data
#       BlogEntry.expects(:by_date).returns(@blog_entries)
#       get :archive, :year => 2024
#     end
#   end
end
