Rails.application.routes.draw do
  resources :courses do
    member do
      post 'enroll'
    end
  end


  resources :courses do
    member do
      post 'enroll'
    end
  end
  

  

  root 'courses#index'
end
