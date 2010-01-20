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
    # Dirty fix for sqlite3
    # find(:all, :select => 'DISTINCT (blog_entries.*)', :joins => [:taggings, :tags], :conditions => {'tags.name' => name })
    columns = 'blog_entries.id,blog_entries.title,blog_entries.permalink,blog_entries.body,blog_entries.created_at,blog_entries.updated_at'
    find(:all, :select => "DISTINCT #{columns}", :joins => [:taggings, :tags], :conditions => {'tags.name' => name })
  end

  private

  def self.organize_blog_entries
    returning Hash.new do |entries|
      years.each do |year|
        months_for(year).each do |month|
          date = Date.new(year, month)
          entries[year] ||= []
          entries[year] << [date.strftime("%B"), BlogEntry.by_date(date, :month)]
        end
      end
    end
  end

  def self.years
    all.map {|e| e.created_at.year }.uniq
  end

  def self.months_for(year)
    all.select {|e| e.created_at.year == year }.map {|e| e.created_at.month }.uniq
  end

  def create_permalink
    self.permalink = title.to_url
  end

end
