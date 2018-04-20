defmodule OptifireWeb.Router do
  use OptifireWeb, :router

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

  scope "/", OptifireWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/pictures", PictureController
  end

  scope "/api", OptifireWeb do
    pipe_through :api

    resources "/pictures", PictureAPIController, only: [:index, :create, :show]
  end
end
