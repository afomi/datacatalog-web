ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => "main", :action => "dashboard"
  map.dashboard "dashboard", :controller => "main", :action => "dashboard"
  map.about "about", :controller => "main", :action => 'about'
  
  map.signout "signout", :controller => "user_sessions", :action => "destroy"
  map.signin "signin", :controller => "user_sessions", :action => "new"
  map.signup "signup", :controller => "users", :action => "new"
  map.confirm 'confirm/:token', :controller => 'users', :action => "confirm"
  
  
  map.resources :users
  map.resource :profile, :controller => "users" do |profile|
    profile.resources :keys
  end
  map.resource :user_session
  
  map.contact "contact", :controller => 'contact', :action => 'index'
  map.contact_submission "contact/submit", :controller => 'contact', :action => 'submit'
  
  map.suggest "suggest", :controller => 'suggest', :action => 'index'
  map.data_suggestion "suggest/suggest", :controller => 'suggest', :action => 'suggest'

  map.search "search", :controller => "search", :action => "index"

  map.browse "browse", :controller => "browse", :action => "index"

  map.resource :admin, :controller => "admin" do |admin|
    admin.resources :sources, :controller => "admin/sources"
    admin.resources :data_suggestions, :controller => "admin/data_suggestions"
    admin.resources :users, :controller => "admin/users" do |user|
      user.resources :keys, :controller => "admin/keys"
    end
    admin.resources :contact_submissions, :controller => "admin/contact_submissions"
  end

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
