Pizza::Application.routes.draw do
  
  # get  'signup', to: 'users#new',        as: 'signup'
  
  get  'login',  to: 'sessions#new',     as: 'login'
  post 'login',  to: 'sessions#create',  as: 'login'
  get  'logout', to: 'sessions#destroy', as: 'logout'
  get  'sessions', to: 'sessions#index', as: 'sessions'
  post 'sessions', to: 'sessions#create'
  # resources :sessions

  get 'weeks',     to: 'weeks#index', as: 'weeks'
  get 'weeks/:id', to: 'weeks#show',  as: 'week'

  get    'unread', to: 'notifications#index',   as: 'notifications'
  delete 'unread', to: 'notifications#destroy', as: 'notifications'

  get 'search', to: 'searches#index'

  resources :searches
  resources :users, except: [:new]
  

  resources :school_days do
    resources :comments
  end


  resources :lectures do
    resources :comments
  end
  get 'lectures/new/preview',      to: 'lectures#new_preview',  as: 'new_lecture_preview'
  get 'lectures/:id/preview',      to: 'lectures#preview',      as: 'lecture_preview'
  get 'lectures/:id/edit/preview', to: 'lectures#edit_preview', as: 'edit_lecture_preview'


  resources :todos do
    resources :comments
  end
  get 'todos/new/preview',      to: 'todos#new_preview',  as: 'new_todo_preview'
  get 'todos/:id/preview',      to: 'todos#preview',      as: 'todo_preview'
  get 'todos/:id/edit/preview', to: 'todos#edit_preview', as: 'edit_todo_preview'
  

  resources :potds do
    resources :comments
  end
  get 'potds/new/preview',      to: 'potds#new_preview',  as: 'new_potd_preview'
  get 'potds/:id/preview',      to: 'potds#preview',      as: 'potd_preview'
  get 'potds/:id/edit/preview', to: 'potds#edit_preview', as: 'edit_potd_preview'


  resources :labs do
    resources :comments
  end
  get 'labs/new/preview',      to: 'labs#new_preview',  as: 'new_lab_preview'
  get 'labs/:id/preview',      to: 'labs#preview',      as: 'lab_preview'
  get 'labs/:id/edit/preview', to: 'labs#edit_preview', as: 'edit_lab_preview'


  resources :links do
    resources :comments
  end
  get 'links/new/preview',      to: 'links#new_preview',  as: 'new_link_preview'
  get 'links/:id/preview',      to: 'links#preview',      as: 'link_preview'
  get 'links/:id/edit/preview', to: 'links#edit_preview', as: 'edit_link_preview'


  resources :homeworks do
    resources :comments
  end
  get 'homeworks/new/preview',      to: 'homeworks#new_preview',  as: 'new_homework_preview'
  get 'homeworks/:id/preview',      to: 'homeworks#preview',      as: 'homework_preview'
  get 'homeworks/:id/edit/preview', to: 'homeworks#edit_preview', as: 'edit_homework_preview'
  

  resources :comments, only: [:index, :create, :update, :destroy]
  get 'discussion', to: 'comments#index', as: 'discussion'

  resources :attachments

  root :to => 'passthrough#index'

end
