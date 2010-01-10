class BlogEntry < ActiveRecord::Base
  is_taggable :tags
  before_save :create_permalink

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
      date = Date.new(*keys.reverse.map {|key| date[key].to_i })
    end

    find(:all, :conditions => {:created_at => (date.send("beginning_of_#{period}")..date.send("end_of_#{period}") )} )
  end 

  def self.by_tag(name)
    find(:all, :select => 'DISTINCT(blog_entries.*)', :joins => [:taggings, :tags], :conditions => {'tags.name' => name })
  end

  private

  def create_permalink
    self.permalink = title.to_url
  end
end
