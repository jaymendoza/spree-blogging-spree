class CreateBlogEntries < ActiveRecord::Migration
  def self.up
    create_table :blog_entries do |t|
      t.column :title, :string
      t.column :body, :text
      t.column :permalink, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :blog_entries
  end
end
