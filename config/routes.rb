ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => "main", :action => "dashboard"
  map.dashboard "dashboard", :controller => "main", :action => "dashboard"
  map.about "about", :controller => "main", :action => 'about'
  map.blog "blog", :controller => "main", :action => "blog"
  
  map.signout "signout", :controller => "user_sessions", :action => "destroy"
  map.signin "signin", :controller => "user_sessions", :action => "new"
  map.signup "signup", :controller => "users", :action => "new"
  map.confirm 'confirm/:token', :controller => 'users', :action => "confirm"  

  map.forgot "forgot", :controller => "password_resets", :action => "new"
  map.send_reset "forgot/sent", :controller => "password_resets", :action => "create"
  map.perform_reset "reset/attempt", :controller => "password_resets", :action => "update"
  map.reset "reset/:token", :controller => "password_resets", :action => "edit"
  
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
    admin.resources :organizations, :controller => "admin/organizations"
    admin.resources :data_suggestions, :controller => "admin/data_suggestions"
    admin.resources :users, :controller => "admin/users" do |user|
      user.resources :keys, :controller => "admin/keys"
    end
    admin.resources :contact_submissions, :controller => "admin/contact_submissions"
  end

  map.source "data/:slug", :controller => "data", :action => "show" 
  map.source_comment "data/:slug/comment", :controller => "data", :action => "comment" 
  map.source_rating "data/:slug/rating/:value", :controller => "data", :action => "rating" 
  map.comment_rating "data/:slug/comment_rating/:comment_id", :controller => "data", :action => "comment_rating" 
  map.source_favorite "data/:slug/favorite", :controller => "data", :action => "favorite" 
  map.source_unfavorite "data/:slug/unfavorite", :controller => "data", :action => "unfavorite" 

  map.source_usages "data/:slug/usages", :controller => "data", :action => "usages" 

  map.source_docs "data/:slug/docs", :controller => "data", :action => "docs" 
  map.source_edit_docs "data/:slug/docs/edit", :controller => "data", :action => "edit_docs" 
  map.source_create_doc "data/:slug/docs/create", :controller => "data", :action => "create_doc"
  map.source_update_doc "data/:slug/docs/:id/update", :controller => "data", :action => "update_doc"   
  map.source_show_doc "data/:slug/docs/:id", :controller => "data", :action => "show_doc"  
  
  map.source_notes "data/:slug/notes", :controller => "data", :action => "notes" 
  map.source_new_note "data/:slug/notes/new", :controller => "data", :action => "new_note"
  map.source_update_note "data/:slug/notes/:note_id", :controller => "data", :action => "update_note"

  map.org "org/:slug", :controller => "org", :action => "show" 

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
