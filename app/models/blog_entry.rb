class BlogEntry < ActiveRecord::Base
  acts_as_url :title
  is_taggable :tags

  validates_presence_of :title
  validates_presence_of :body

  default_scope :order => "created_at DESC"

  def self.latest(limit = 3)
    find(:all, :limit => limit)
  end

  def self.by_date(date, period = nil)
    if date.is_a?(Hash)
      keys = [:day, :month, :year].select {|key| date.include?(key) }
      period = keys.first.to_s
      date = Date.new(*keys.map {|key| date[key].to_i }.reverse)
    end

    find(:all, :conditions => {:created_at => (date.send("beginning_of_#{period}")..date.send("end_of_#{period}") )} )
  end 

  def self.by_tag(name)
    find(:all, :select => 'DISTINCT(blog_entries.*)', :joins => [:taggings, :tags], :conditions => {'tags.name' => name })
  end

  def permalink
    "/blog/#{created_at.year}/#{created_at.month}/#{created_at.day}/#{url}"
  end
end
