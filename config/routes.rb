Rails.application.routes.draw do
  match 'blog/:year/:month/:day/:slug', :to => 'blog_entries#show', :as => :entry_permalink

  match 'blog/:year(/:month)(/:day)', :to => 'blog_entries#archive', :as => :news_archive,
    :constraints => {:year => /(19|20)\d{2}/, :month => /[01]?\d/, :day => /[0-3]?\d/}

  resources :blog_entries

  namespace :admin do
    resources :blog_entries
  end

  match 'blog/tag/:tag', :to => 'blog_entries#tag', :as => :tag
end
