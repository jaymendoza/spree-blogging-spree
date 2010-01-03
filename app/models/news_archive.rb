class NewsArchive
  attr_reader :entries

  def initialize
    @entries = []
    process_entries
  end

  def years
    BlogEntry.all.map {|e| e.created_at.year }.uniq.sort.reverse
  end

  def months_for(year)
    BlogEntry.all.select {|e| e.created_at.year == year }.
                  map {|e| e.created_at.month }.uniq.sort.reverse
  end

  def process_entries
    years.each do |year|
      months_for(year).each do |month|
        date = Date.new(year, month)
        @entries << [year, [[date.strftime("%B"), BlogEntry.for_month(date)]]]
      end
    end
  end
end
