class NewsArchive
  attr_accessor :entries, :years

  def initialize
    @entries = BlogEntry.all
  end

  def find_years
    @years = @entries.map {|e| e.created_at.year }.uniq
  end

  def find_months_for_year(year)
    @entries.select {|e| e.created_at.year == year }.map {|ey| ey.created_at.strftime("%B") }.uniq
  end

  def years_with_months
    returning Hash.new do |hash|
      @years.each do |year|
        hash[year] = find_months_for_year(year)
      end
    end
  end

end
