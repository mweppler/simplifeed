Simplifeed::Application.routes.draw do
  root :to => 'home#index'
  
  # Callback and failure for providers
  match '/users/auth/:provider/callback' => 'authentications#create'
  match '/users/auth/failure' => 'authentications#failure'

  # Used for connecting facebook, etc. with an existing username/password account
  match '/connect/:provider' => 'authentications#connect'
  
  # Main feed
  match '/feed' => 'users#show'
  
  # Mentions
  match '/mentions' => 'posts#mentions'
  
  # Favs
  match '/favs' => 'posts#favs'
  
  # Devise
  devise_for :users do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
    match '/users/show' => 'users#show'
    match '/users/show' => 'users#show'
    match '/users/show' => 'users#show'
  end
  
  # API and tokens
  namespace :api do
    namespace :v1  do
      resources :tokens,:only => [:create, :destroy]
    end
  end

  # Twitter, Facebook, and LinkedIn feeds
  match '/user/post' => 'users#post'
  
  # Update post content
  match '/user/update_post' => 'users#update_post'
  
  # Reply to post
  match '/user/reply_to_post' => 'users#reply_to_post'
  
  # List users, find friends
  match '/friends' => 'users#list'
  
  # List recent chat and get online users
  match '/chat' => 'users#online_friends'
  
  # Like post
  match '/like_post' => 'posts#like_post'
  
  # Send message
  match '/send_message' => 'messages#send_message'
  
  # Request friendship
  match '/user/request_friendship' => 'users#request_friendship'
  
  # Unfriend
  match '/user/unfriend' => 'users#unfriend'
  
  # Approve friendship
  match '/user/approve_friendship' => 'users#approve_friendship'
  
  # Mark message read
  match '/user/dismiss_notification' => 'users#dismiss_notification'
  
  # Dismiss notification
  match '/mark_as_read' => 'messages#mark_as_read'

  # Resources for posts
  resources :posts
  
  # Get profiles by username
  get "/:id", :to => "users#profile", :as => :user, :constraints => { :id => /.*/ }
  
  resources :links do
    match ':in_url' => 'links#go' #added this line
  end
end