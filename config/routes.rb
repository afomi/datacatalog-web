ActionController::Routing::Routes.draw do |map|
  
  map.root                                                        :controller => "main",            :action => "dashboard"
  map.about              "about",                                 :controller => "main",            :action => "about"
  map.blog               "blog",                                  :controller => "main",            :action => "blog"
  map.browse             "browse",                                :controller => "browse",          :action => "index"
  map.confirm            "confirm/:token",                        :controller => "users",           :action => "confirm"
  map.contact            "contact",                               :controller => "contact",         :action => "index"
  map.contact_submission "contact/submit",                        :controller => "contact",         :action => "submit"
  map.dashboard          "dashboard",                             :controller => "main",            :action => "dashboard"
  map.data_suggestion    "suggest/suggest",                       :controller => "suggest",         :action => "suggest"
  map.forgot             "forgot",                                :controller => "password_resets", :action => "new"
  map.org                "org/:slug",                             :controller => "org",             :action => "show"
  map.perform_reset      "reset/attempt",                         :controller => "password_resets", :action => "update"
  map.reset              "reset/:token",                          :controller => "password_resets", :action => "edit"
  map.search             "search",                                :controller => "search",          :action => "index"
  map.send_reset         "forgot/sent",                           :controller => "password_resets", :action => "create"
  map.signin             "signin",                                :controller => "user_sessions",   :action => "new"
  map.signout            "signout",                               :controller => "user_sessions",   :action => "destroy"
  map.signup             "signup",                                :controller => "users",           :action => "new"
  map.source             "data/:slug",                            :controller => "data",            :action => "show"
  map.source_comment     "data/:slug/comment",                    :controller => "data",            :action => "comment"
  map.comment_rating     "data/:slug/comment_rating/:comment_id", :controller => "data",            :action => "comment_rating"
  map.source_create_doc  "data/:slug/docs/create",                :controller => "data",            :action => "create_doc"
  map.source_docs        "data/:slug/docs",                       :controller => "data",            :action => "docs"
  map.source_edit_docs   "data/:slug/docs/edit",                  :controller => "data",            :action => "edit_docs"
  map.source_favorite    "data/:slug/favorite",                   :controller => "data",            :action => "favorite"
  map.source_new_note    "data/:slug/notes/new",                  :controller => "data",            :action => "new_note"
  map.source_notes       "data/:slug/notes",                      :controller => "data",            :action => "notes"
  map.source_rating      "data/:slug/rating/:value",              :controller => "data",            :action => "rating"
  map.source_show_doc    "data/:slug/docs/:id",                   :controller => "data",            :action => "show_doc"
  map.source_unfavorite  "data/:slug/unfavorite",                 :controller => "data",            :action => "unfavorite"
  map.source_update_doc  "data/:slug/docs/:id/update",            :controller => "data",            :action => "update_doc"
  map.source_update_note "data/:slug/notes/:note_id",             :controller => "data",            :action => "update_note"
  map.source_usages      "data/:slug/usages",                     :controller => "data",            :action => "usages"
  map.suggest            "suggest",                               :controller => "suggest",         :action => "index"
  
  map.resources :users
  map.resource :profile, :controller => "users" do |profile|
    profile.resources :keys
  end
  map.resource :user_session

  map.resource :admin, :controller => "admin" do |admin|
    admin.resources :sources,             :controller => "admin/sources" do |source|
      source.resources :downloads,        :controller => "admin/downloads"
    end
    admin.resources :organizations,       :controller => "admin/organizations"
    admin.resources :data_suggestions,    :controller => "admin/data_suggestions"
    admin.resources :users,               :controller => "admin/users" do |user|
      user.resources :keys,               :controller => "admin/keys"
    end
    admin.resources :contact_submissions, :controller => "admin/contact_submissions"
  end

  map.connect ":controller/:action/:id"
  map.connect ":controller/:action/:id.:format"

end
