Rails.application.routes.draw do
  get  '/searches', to: 'searches#apply'
  post '/commands', to: 'commands#apply'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure',            to: redirect('/')
  get 'signout',                 to: 'sessions#destroy'
  get 'me',                      to: 'sessions#me'
end
