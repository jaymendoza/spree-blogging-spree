class NewsArchive
  attr_accessor :entries, :years

  def self.generate
    self.new.map_entries
  end

  def initialize
    @entries = BlogEntry.all
    find_years
  end

  def find_years
    @years = @entries.map {|e| e.created_at.year }.uniq.sort.reverse
  end

  def find_months_for_year(year)
    @entries.select {|e| e.created_at.year == year }.
                map {|e| e.created_at.month }.uniq.sort.reverse
  end

  def years_with_months
    returning Array.new do |ary|
      @years.each do |year|
        ary << [year, find_months_for_year(year)]
      end
    end
  end

  def months_with_entries(year, months)
    returning Array.new do |ary|
      months.each do |month|
        date = DateTime.new(year, month)
        ary << [date.strftime("%B"), BlogEntry.for_month(date)]
      end
    end
  end

  def map_entries
    returning Array.new do |ary|
      years_with_months.each do |year, months|
        ary << [year, months_with_entries(year, months)]
      end
    end
  end

end
