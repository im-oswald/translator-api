Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :glossaries, only: %i(index show create) do
        resources :terms, only: %i(create)
      end

      resources :translations, only: %i(show create)
    end
  end
end
