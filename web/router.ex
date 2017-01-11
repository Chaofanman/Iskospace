defmodule Iskospace.Router do
  use Iskospace.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Iskospace.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Iskospace do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

    resources "/users", UserController do
      resources "/posts", PostController
    end

    resources "/posts", PostController, only: [] do
      resources "/comments", CommentController, only: [:create, :delete]
    end 

    get "/tags", TagController, :index
    get "/tags/:tag", TagController, :show

  end

  # Other scopes may use custom stacks.
  # scope "/api", Iskospace do
  #   pipe_through :api
  # end
end
