Blog::Application.routes.draw do
  root 'index#index'

  # Permalink
  get ':year/:month/:slug', {
    :to => 'index#permalink',
    :constraints => {
      :year => /20[0-9][0-9]/,
      :month => /[0-9][0-9]/,
    },
  }

  namespace :admin do
    root 'index#index'
    resources :users, :categories, :posts
  end
end
