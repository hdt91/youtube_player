defmodule YoutubePlayer.Router do
  @moduledoc """
  Require Ueberauth to enable its macro
  """

  use YoutubePlayer.Web, :router
  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug YoutubePlayer.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", YoutubePlayer do
    pipe_through [:browser, :auth]

    get "/", PageController, :index
    resources "/users", UserController
  end

  scope "/auth", YoutubePlayer do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", YoutubePlayer do
  #   pipe_through :api
  # end
end
