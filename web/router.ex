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
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    resources "/users", UserController do
      resources "/posts", PostController
    end

    resources "/posts", PostController, only: [:index, :show]
    resources "/comments", CommentController, except: [:delete]

    resources "/reviews", ReviewController
  end

  #scope "/admin" same as scope "/dmin"
  scope "/admin" do
    pipe_through :browser

    resources "/images",  HelloPhoenix.Admin.ImageController
    resources "/reviews", HelloPhoenix.Admin.ReviewController
    resources "/users",   HelloPhoenix.Admin.UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloPhoenix do
  #   pipe_through :api
  # end
end
