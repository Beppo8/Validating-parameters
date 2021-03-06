defmodule TeacherWeb.Router do
  use TeacherWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TeacherWeb.Plugs.SetAuth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TeacherWeb do
    pipe_through :browser

    resources "/sessions", SessionController, only: [:new, :create]
    delete "/sign-out", SessionController, :delete
    resources "/registrations", RegistrationController, only: [:new, :create]

    resources "/albums", AlbumController
    resources "/users", UserController, only: [:show]
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", TeacherWeb.Api, as: :api do
    pipe_through :api

    resources "/albums", AlbumController, only: [:show, :index]
  end
end
