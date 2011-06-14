Refinery::Application.routes.draw do
  resources :events do
    collection do
      get 'archive/:year(/:month)' => 'events#archive', :as => 'archive'
      get 'category/:id' => 'event_categories#show', :as => 'category'
    end
  end
  
  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :events, :except => :show
    resources :event_categories, :except => :show
  end
end
