Rails.application.routes.draw do
  get 'admin/add_emoployee'
  resources :fixed_issues
  resources :photos
  resources :employees 
  resources :users do
    member do
      get :personal_page
      get :support
    end
  end
  resources :problems do 
    member do
      get :accept
    end
  end
  get "/new_problem", to: "problems#new"
  ## Accept issue
  post "/acce_matt", to: "problems#accept_mat"
  post "/accept", to: "problems#accept_issue"
  get "/accept", to: "problems#accept"
  
  get "/submit", to: "problems#new"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get "/", to: "homepage#home_page"
  #hom page
  get "/", to: 'homepage#home_page'

  get "/new", to: "sessions#new"
  post "/user", to: "sessions#create"
  post "/login", to: "sessions#login"
  get "/index", to: "users#index"
  get "/log_out", to: "users#log_out"
  get "/login", to: "sessions#log_in"
  get "/new_issue", to: "issues#new"
  # post "/issue", to: "issues#create"
  get "/show", to: "issues#show"
  # get "/pass", to: "employees#pass"
  post "/problem", to: "employees#update"
  get "/issue", to: "employees#issue"
  get "/new_user", to: "sessions#new_user"
  get "/user", to: "employees#user"
  get "/profile", to: "users#profile"
  post "/upprofile", to: "users#update_profile"
  post "/edit_user", to: "users#update"
  post "/pass", to: "employees#pass"
  post "/block", to: "employees#block"
  post "/active", to: "employees#active"
  get "/submit_issue", to: "problems#new"
  post "/submit_issue", to: "problems#create"
  # post "/issue_accept", to: "users#accept_issue"
  post "/feed", to: "sessions#comment"
  post "/confirm", to: "problems#confirm"
  # post "/bill_of_material", to: "users#accept_issue"
  post "/confirm_issue", to: "employees#confirm"
  get "/report", to: "employees#report"
  get "/about", to: "employees#about"
  post "/select", to: "employees#about"
  get "/confirmed_issue", to: "users#confirmed_issue"
  get "/help", to: "additions#help"
  get "/addition", to: "additions#addition"
  post "/gover", to: "additions#new_gover"
  post "/city", to: "additions#new_city"
  post "/cat", to: "additions#new_cat"
  post "/mat", to: "additions#new_mat"
  get "/accept_status", to: "users#accept_status"
  # post "/accept", to: "users#accept_problem"
  post "/join_issue", to: "users#join"
  #meassages
  get "/meassage", to: "users#meassage"
  #image
  post "/image", to: "users#upimage"
  ##personal_page
  get "/personal_page", to: "users#personal_page"
  get "/log", to: "users#log"

  ##Add Bio
  post "/bio", to: "users#add_bio"
  ## supporte money
  post "/money", to: "users#support_money"
  ## support matterails
  post '/supmat', to: "users#support_mat"

  ##spervisor
  get "/supervisor", to: "users#supervisor"
  ## accept materails
  post '/accmat', to: 'users#accept_mat'
  ## accept money
  post '/accmoney', to: 'users#accept_money'
  ##my accept
  post '/myacc', to: 'problems#done'
  ## done
  post '/done',to: 'problems#donesup'
  ## fixed_issues
  get '/fixed_issue',to: 'fixed_issues#index'
  #repoorts
  get '/report', to: 'employees#report'
  ##area
  post '/area',to: 'additions#create_area'
  ## admins
  get '/add_emoployee',to: 'admin#add_emoployee'
  post "/employee", to: "admin#create"

  resources :users do
    member do
      patch :accept
    end
  end
  resources :issues
  resources :employees do
    member do
      patch :block
      post :pass
    end
  end
end

