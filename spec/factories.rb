Factory.define :blog_entry do |e|
  e.title 'A Blog Title'
  e.body 'A Blog Body'
  e.sequence(:created_at) {|year| DateTime.new((year + 2000), 12, 25) }
end
