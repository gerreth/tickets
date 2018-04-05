defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug Hello.Auth.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    pipe_through [:browser, :auth] # Use the default browser stack

    get "/", PageController, :index
    # Handling login/logout
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
    # Resources
    resources "/users", UserController, only: [:create, :new]
  end

  scope "/", HelloWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    # Resources
    resources "/tickets", TicketController
    resources "/users", UserController, only: [:delete, :edit, :index, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end
end
