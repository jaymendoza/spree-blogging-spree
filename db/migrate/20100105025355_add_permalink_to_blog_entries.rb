class AddPermalinkToBlogEntries < ActiveRecord::Migration
  def self.up
    add_column :blog_entries, :permalink, :string
  end

  def self.down
    remove_column :blog_entries, :permalink
  end
end
