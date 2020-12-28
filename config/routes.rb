Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Jak::Engine => '/jak'

  # TODO: nest this under companies
  resources :users

  resources :companies do
    resources :roles
    resources :leads
  end

  devise_for :users, path: 'u'

  root to: 'marketing/landing#index'

  # mount ActionCable.server => '/cable'
end
