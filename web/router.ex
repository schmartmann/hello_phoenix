defmodule HelloPhoenix.Router do
  use HelloPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, except: [:index] do 
      resources "/posts", PostController
    end
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show 
    get "/", RootController, :index
    resources "/reviews", ReviewController
  end

  scope "/admin", HelloPhoenix.Admin, as: :admin do 
    pipe_through :browser
    
    resources "/images", ImageController
    resources "/reviews", ReviewController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloPhoenix do
  #   pipe_through :api
  # end
end
