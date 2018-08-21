Refinery::Core::Engine.routes.draw do
  namespace :calendar, :path => Refinery::Calendar.page_url do
    root :to => 'events#index'

    get 'events/archive' => 'events#archive'

    resources :events, :only => [:index, :show]

    resources :venues, :only => [:index, :show]
  end


  namespace :calendar, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      scope :path => Refinery::Calendar.page_url do
        root :to => 'events#index'

        resources :events, except: :show do
          collection do
            post :update_positions
          end
        end

        resources :venues, except: :show do
          collection do
            post :update_positions
          end
        end
      end
    end
  end

end
