map.entry_permalink 'blog/:year/:month/:day/:slug', :controller => 'blog_entries', :action => 'show'

map.news_archive 'blog/:year/:month/:day', :controller => 'blog_entries', :action => 'archive',
   :requirements => {:year => /(19|20)\d{2}/, :month => /[01]?\d/, :day => /[0-3]?\d/},
   :month => nil, :day => nil

map.resources :blog_entries, :as => 'blog'

map.namespace :admin do |admin|
  admin.resources :blog_entries, :as => 'blog'
end

map.tag 'blog/tag/:tag', :controller => 'blog_entries', :action => 'tag'
