class BlogEntry < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :body

  def self.latest(limit = 3)
      find(:all, :order => "created_at DESC", :limit => limit)
  end
end
