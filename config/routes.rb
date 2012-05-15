Rails.application.routes.draw do
  match 'news/:year/:month/:day/:slug', :to => 'blog_entries#show', :as => :entry_permalink

  match 'news/:year(/:month)(/:day)', :to => 'blog_entries#archive', :as => :news_archive,
    :constraints => {:year => /(19|20)\d{2}/, :month => /[01]?\d/, :day => /[0-3]?\d/}

  resources :news, :controller => :blog_entries

  namespace :admin do
    resources :blog_entries
  end

  match 'news/tag/:tag', :to => 'blog_entries#tag', :as => :tag
end
