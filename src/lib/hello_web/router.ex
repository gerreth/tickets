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

  pipeline :graphql do
    plug Hello.Context
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
    resources "/users", UserController
    # Additional routes for user resource
    post "/users/:id/toggle_status", UserController, :toggle_status
  end

  scope "/api" do
    pipe_through [:api, :graphql]

    forward "/v1", Absinthe.Plug,
      schema: HelloWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: HelloWeb.Schema,
      interface: :simple,
      context: %{pubsub: HelloWeb.Endpoint}
  end
end
