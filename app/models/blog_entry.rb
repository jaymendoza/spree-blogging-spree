class BlogEntry < ActiveRecord::Base
  is_taggable :tags
  before_save :create_permalink
  validates_presence_of :title
  default_scope :order => "created_at DESC"

  def self.by_date(date, period = nil)
    if date.is_a?(Hash)
      keys = [:day, :month, :year].select {|key| date.include?(key) }
      period = keys.first.to_s
      date = Date.new(*keys.reverse.map {|key| date[key].to_i })
    end

    time = date.to_time.in_time_zone
    find(:all, :conditions => {:created_at => (time.send("beginning_of_#{period}")..time.send("end_of_#{period}") )} )
  end 

  def self.by_tag(name)
    find(:all, :select => 'DISTINCT blog_entries.*', :joins => [:taggings, :tags], :conditions => {'tags.name' => name })
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

  def validate
    # nicEdit field contains "<br>" when blank
    errors.add(:body, "can't be blank") if body =~ /^<br>$/
  end

end
