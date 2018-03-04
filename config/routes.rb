Rails.application.routes.draw do
  get  '/searches', to: 'searches#apply'
  post '/commands', to: 'commands#apply'
end
