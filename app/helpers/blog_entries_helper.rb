module BlogEntriesHelper
  def entry_permalink(e)
    d = e.created_at
    entry_permalink_path :year => d.year, :month => d.month, :day => d.day, :slug => e.permalink
  end
end
