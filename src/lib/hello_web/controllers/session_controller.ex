defmodule HelloWeb.SessionController do
  use HelloWeb, :controller

  alias Hello.Auth
  alias Hello.Auth.Guardian

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, session_params) do
    case Auth.login(session_params) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_session(:current_user, user.id)
        |> put_session(:current_user_name, user.username)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:error, "Incorrect email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> delete_session(:current_user)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end
end
