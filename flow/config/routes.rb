Flow::Application.routes.draw do

  match "/report_data_entry"                     => "reports#report_data_entry"


  get "chart/org_context"
  get "chart/org_context_print"

  # match "/chart/org_context"          => "chart#org_context"

  resources :portfolios
  resources :plans
  resources :milestones
  resources :resource_allocations

  resources :people do
    collection do
      match 'search' => 'people#search', :via => [:get, :post], :as => :search
    end
  end

  resources :person_associations

  # devise_for :users
  devise_for :users,  :controllers => { :registrations => "users/registrations" }
  resources :users

  resources :widgets do
    resources :parts
  end

  resources :employees do
    collection do
      match 'search' => 'employees#search', :via => [:get, :post], :as => :search
    end
  end
  resources :reporting_relationships

  get "home/index"

  match "/release_calendar"          => "home#release_calendar"

  match "/orgchart"                  => "home#orgchart"                            # deprecated

  match "/people_tree"               => "home#people_tree"                         # people
  match "/people_tree_data"          => "home#people_tree_data"                    # people, json

  match "/orgdendro"                 => "home#orgdendro"                           # employees
  match "/orgdendro_tree"            => "home#orgdendro_tree"                      # employees, json

  match "/staffingchart"             => "home#staffingchart"

  match "/budgetchart"               => "home#budgetchart"
  match "/budgetchart_dynamic"       => "home#budgetchart_dynamic"


  root :to => 'home#index'
end
