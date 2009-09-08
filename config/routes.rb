ActionController::Routing::Routes.draw do |map|
  map.resources :capacities
  map.resources :drivers
  map.root :controller => "capacities", :action => :index
end
