# -*- coding: utf-8 -*-
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
    # find(:all, :select => 'DISTINCT (blog_entries.*)', :joins => [:taggings, :tags], :conditions => {'tags.name' => name })

    # Dirty fix.
    ## We need to do the following, since sqlite can not correctly
    ## handle DISTINCT (blog_entries.*)
    ## SQLite3::SQLException: near "*": syntax error: SELECT DISTINCT (blog_entries.*) FROM "blog_entries"   INNER JOIN "taggings" ON "taggings".taggable_id = "blog_entries".id AND "taggings".taggable_type = 'BlogEntry' INNER JOIN "taggings" tags_blog_entries_join ON ("blog_entries"."id" = "tags_blog_entries_join"."taggable_id" AND "tags_blog_entries_join"."taggable_type" = 'BlogEntry')  INNER JOIN "tags" ON ("tags"."id" = "tags_blog_entries_join"."tag_id")  WHERE ("tags"."name" = 'новинки')  ORDER BY created_at DESC
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
