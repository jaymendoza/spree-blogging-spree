class NewsArchive
  attr_accessor :entries, :years

  def initialize
    @entries = BlogEntry.all
  end

  def find_years
    @years = @entries.map {|e| e.created_at.year }.uniq
  end

end
