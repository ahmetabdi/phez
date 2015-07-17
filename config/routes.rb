Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :posts, only: [:show] do
        collection do
          get 'all'
        end
      end
      resources :subphezes, only: [] do
        collection do
          get 'top'
          get ':path/all' => 'subphezes#all'
          get ':path/latest' => 'subphezes#latest'
        end
      end
      resources :profiles, only: [:show] do
        collection do
          get ':username/details' => 'profiles#show'
          get ':username/posts' => 'profiles#posts'
          get ':username/comments' => 'profiles#comments'
        end
      end
    end
  end

  resources :rewards, :only => [:new, :create] do
    collection do
      get 'premium'
    end
    member do
      get 'thanks'
    end
  end
  resources :credits, :only => [] do
    collection do
      get 'leaderboard'
      get 'posters_csv'
    end
  end
  resources :subscriptions, :only => [:create, :destroy]
  resources :comments, :only => [:show, :create, :edit, :update, :destroy]
  resources :posts, :except => [:index] do
    collection do
      get 'suggest_title'
    end
  end
  resources :messages, :only => [:index, :new, :create]
  resources :profiles, :only => [:show] do
    member do
      get 'comments'
    end
  end

  resources :users, :only => [] do
    collection do
      get 'subscriptions'
      get 'change_password'
      patch 'update_password'
    end
  end

  resources :home, :only => [:index] do
    collection do
      get 'privacy'
      get 'thanks'
    end
  end

  get 'p/:path' => 'subphezes#show', as: :view_subphez
  get 'p/:path/latest' => 'subphezes#latest', as: :subphez_latest
  get 'p/:path/manage' => 'subphezes#manage', as: :manage_subphez
  post 'p/:path/add_moderator' => 'subphezes#add_moderator', as: :add_moderator_subphez
  post 'p/:path/remove_moderator' => 'subphezes#remove_moderator', as: :remove_moderator_subphez
  get 'p/:path/approve_modrequest' => 'subphezes#approve_modrequest', as: :approve_modrequest
  post 'p/:path/update_modrequest' => 'subphezes#update_modrequest', as: :update_modrequest
  get 'p/:path/submit' => 'posts#new', as: :new_subphez_post
  get 'p/:path/:post_id/:guid/' => 'posts#show', as: :view_post

  post 'votes/upvote' => 'votes#upvote'
  post 'votes/downvote' => 'votes#downvote'

  post 'comment_votes/upvote' => 'comment_votes#upvote'
  post 'comment_votes/downvote' => 'comment_votes#downvote'

  resources :subphezes, :except => [:destroy]
  devise_for :users, :controllers => {:registrations => "registrations"}

  get 'my' => 'home#my', as: :my
  root 'home#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
