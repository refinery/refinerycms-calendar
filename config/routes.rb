Refinery::Application.routes.draw do
  resources :events do
    get 'archive/:year(/:month)' => 'events#archive', :as => 'archive', :on => :collection
  end
  
  post "events/:id/comments" => "comments#create", :as => 'comments'
  post "comments/:id/reply" => "comments#reply", :as => 'comment_reply'
  
  resources :event_categories, :only => :show

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :events, :except => :show
    resources :event_categories, :except => :show
  end
end
