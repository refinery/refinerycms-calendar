Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :calendar do
    get 'events/archive' => 'events#archive'
    resources :events, :only => [:index, :show]
    resources :categories, :only => [:index, :show]
  end

  # Admin routes
  namespace :calendar, :path => '' do
    namespace :admin, :path => 'refinery/calendar' do
      resources :events, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

  # Admin routes
  namespace :calendar, :path => '' do
    namespace :admin, :path => 'refinery/calendar' do
      resources :venues, :except => :show do
        collection do
          post :update_positions
        end
      end
      resources :categories, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
