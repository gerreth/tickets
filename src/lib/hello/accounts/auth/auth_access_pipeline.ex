defmodule Hello.Auth.AuthAccessPipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline, otp_app: :hello

  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access", error_handler: Hello.Auth.AuthErrorHandler})
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
