Factory.define :blog_entry do |e|
  e.title 'A Blog Entry Title'
  e.body 'A Blog Entry Body'
  e.permalink {|entry| entry.title.to_url }
  e.created_at Date.new(2010)
end

Factory.define :tag do |t|
  t.name 'foo'
  t.kind 'tag'
end

Factory.define :tagging do |t|
  t.association :tag
  t.taggable_type 'BlogEntry'
  t.association :taggable
end
