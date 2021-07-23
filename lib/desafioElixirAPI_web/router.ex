defmodule DesafioElixirAPIWeb.Router do
  @moduledoc """
  sets up all necessary routing configurations for the API.
  """

  use DesafioElixirAPIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DesafioElixirAPIWeb do
    pipe_through :api

    resources("/users", UserController, except: [:new, :edit])

    post "/operation", OperationController, :create
    get "/operation", OperationController, :show_all
    get "/operation/:id", OperationController, :show_one
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: DesafioElixirAPIWeb.Telemetry
    end
  end
end
