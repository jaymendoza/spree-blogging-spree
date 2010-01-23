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

  context "on GET to archive with a year" do
    setup do
      Factory(:blog_entry, :created_at => Date.new(2020, 1))
      Factory(:blog_entry, :created_at => Date.new(2020, 2))
      get :archive, :year => 2020
    end

    should_respond_with :success
    should_render_template :index
    should_assign_to(:blog_entries) { BlogEntry.all }

    should "see the dates in the widget" do
      assert_contain I18n.l( BlogEntry.first.created_at.to_date, :format => :long)
      assert_contain I18n.l( BlogEntry.last.created_at.to_date, :format => :long)
    end
  end

  context "on GET to tag with a tag" do
    setup do
      blog_entry = Factory(:blog_entry)
      @tag = Factory(:tag, :name => "baz")
      Factory(:tagging, :tag => @tag, :taggable => blog_entry)
      get :tag, :tag => @tag.name
    end

    should_respond_with :success
    should_render_template :index
    should_assign_to(:blog_entries) { BlogEntry.all }

    should "see the tag within the tag list" do
      assert_have_selector "div[class='tags']/a[href='#{tag_path(@tag.name)}']"
    end
  end
end
