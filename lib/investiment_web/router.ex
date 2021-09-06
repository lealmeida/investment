defmodule InvestimentWeb.Router do
  use InvestimentWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug InvestimentWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", InvestimentWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/transaction/new", TransactionController, :new
    post "/transaction", TransactionController, :create

    get "/asset/:id/dividend/new", DividendController, :new
    post "/asset/:id/dividend", DividendController, :create
    get "/my-dividends", DividendController, :index

  end

  # Other scopes may use custom stacks.
  # scope "/api", InvestimentWeb do
  #   pipe_through :api
  # end
  scope "/auth", InvestimentWeb do
    pipe_through :browser

    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
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
      pipe_through :browser
      live_dashboard "/dashboard", metrics: InvestimentWeb.Telemetry
    end
  end
end
