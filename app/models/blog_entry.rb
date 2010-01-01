class BlogEntry < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :body

  def self.latest(limit = 3)
      find(:all, :order => "created_at DESC", :limit => limit)
  end

  named_scope :for_month, lambda {|date| {
    :conditions => {:created_at => (date.beginning_of_month..date.end_of_month) },
    :order => "created_at DESC" } }
end
