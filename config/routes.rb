Refinery::Application.routes.draw do
  resources :events do
    get 'archive/:year(/:month)' => 'events#archive', :as => 'archive', :on => :collection
  end
  
  post "comments" => "comments#create"
  post "comments/:id/reply" => "comments#reply", :as => 'comment_reply'

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :events, :except => :show
  end
end
