Flow::Application.routes.draw do

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

  devise_for :users

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
  match "/orgchart"                  => "home#orgchart"
  match "/orgdendro"                 => "home#orgdendro"
  match "/orgdendro_tree"            => "home#orgdendro_tree" # json
  match "/budgetchart"               => "home#budgetchart"
  match "/budgetchart_dynamic"       => "home#budgetchart_dynamic"
  match "/staffingchart"             => "home#staffingchart"

  root :to => 'home#index'
end
