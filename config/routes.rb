# Encoding: utf-8

# The MIT License (MIT)
#
# Copyright (c) 2014 Richard Buggy <rich@buggy.id.au>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
  devise_for :users,
             path_names: { sign_in: 'login',
                           sign_out: 'logout',
                           sign_up: 'register' },
             controllers: { sessions: 'users/sessions',
                            passwords: 'users/passwords',
                            registrations: 'users/registrations',
                            unlocks: 'users/unlocks' }

  namespace :admin do
    resources :accounts, except: [:destroy] do
      get 'cancel' => 'accounts#confirm_cancel'
      patch 'cancel' => 'accounts#cancel'
      get 'events' => 'accounts#events'
      get 'restore' => 'accounts#confirm_restore'
      patch 'restore' => 'accounts#restore'
      get 'users' => 'accounts#users'
    end
    resources :plans do
      get 'accounts' => 'plans#accounts'
    end
    resources :users do
      get 'accounts' => 'users#accounts'
    end
    get 'events' => 'dashboard#events'
    get 'jobs' => 'dashboard#jobs'
    root to: 'dashboard#index'
  end

# To use path based multi-tenant routing you need to wrap the application routes in scope that defines :path and define
# the root_path inside that. For example:
#
# scope ':path' do
#   namespace :settings do
#     resource :account, only: [:show, :edit, :update]
#     // More setting paths here...
#   end
#   // Your application specific paths here
#   root to: 'dashboard#index', as: :root
# end
#
# You will probably also want to remove the constraints around the marketing controller that restrict it to just the
# marketing website. Once that's done you will then need to fix the tests. There is already code in the
# ApplicationController to use params[:path] to identify the account if it's found

  namespace :settings do
    resource :account, only: [:show, :edit, :update]
    resource :plan, only: [:show, :update, :destroy] do
      get 'cancel'
      patch 'pause'
      get ':id' => 'plans#edit', as: :edit
    end
#    resource :card, only: [:show, :update]
#    resources :users
    root to: 'accounts#home'
  end

  constraints :subdomain => 'www' do
    get 'pricing' => 'marketing#pricing'
    get 'signup/:plan_id' => 'marketing#signup', as: :signup
    post 'signup' => 'marketing#register', as: :register
    root to: 'marketing#index', as: :marketing_root
  end
  root to: 'dashboard#index'
end
