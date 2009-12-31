Factory.define :blog_entry do |e|
  e.title 'A Blog Title'
  e.body 'A Blog Body'
end

Factory.define :blog_entry_months, :parent => :blog_entry do |e|
  e.sequence(:created_at) {|month| DateTime.new(2009, month, 25) }
end
