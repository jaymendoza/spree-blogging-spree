Factory.define :blog_entry do |e|
  e.title 'A Blog Entry Title'
  e.body 'A Blog Entry Body'
  e.url {|entry| entry.title.to_url }
  e.created_at Date.new(2010)
end
