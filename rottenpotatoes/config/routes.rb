Rottenpotatoes::Application.routes.draw do
  # a RESTful route for Find Similar Movies
  get 'movies/:id/fdirector', to: 'movies#fdirector', as:'fdirector_movie'
  resources :movies
  
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
