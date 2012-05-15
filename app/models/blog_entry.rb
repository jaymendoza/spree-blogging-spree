require "is_taggable"

class BlogEntry < ActiveRecord::Base
  
  def initialize(attributes={})
    date_hack(attributes, "created_at") unless attributes.nil?
    super(attributes)
  end
  
  def update_attributes(attributes={})
    date_hack(attributes, "created_at") unless attributes.nil?
    super(attributes)
  end

  def date_hack(attributes, property)
    keys, values = [], []
    attributes.each_key {|k| keys << k if k =~ /#{property}/ }.sort
    keys.each { |k| values << attributes[k]; attributes.delete(k); }
    attributes[property] = values.join("-") 
  end
  
  is_taggable :tags
  before_save :create_permalink
  validates_presence_of :title

  default_scope order("created_at DESC")
  scope :published, lambda { where("blog_entries.created_at <= ?", Time.zone.now) }
  scope :latest, lambda { |n| published.limit(n.to_i) }

  has_many :images, :as => :viewable, :dependent => :destroy, :class_name => "BlogEntryImage"

  accepts_nested_attributes_for :images, :reject_if => lambda { |a| a[:attachment].blank? && a[:_destroy] != "1" }, :allow_destroy => true
 
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

  def self.archives_before(date)
      published.where("blog_entries.created_at < ?", date)
  end

  def self.organize_archives(before=nil)
    before ||= Date.now
    Hash.new.tap do |entries|
      years.each do |year|
        months_for(year, before).each do |month|
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

  def self.months_for(year, before)
    all.select {|e| e.created_at.year == year && e.created_at < before }.map {|e| e.created_at.month }.uniq
  end

  def create_permalink
    self.permalink = title.to_url
  end

  def validate
    # nicEdit field contains "<br>" when blank
    errors.add(:body, "can't be blank") if body =~ /^<br>$/
  end

end
