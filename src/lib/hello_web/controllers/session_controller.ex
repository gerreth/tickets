defmodule HelloWeb.SessionController do
  use HelloWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Hello.Auth.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> Hello.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: user_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Hello.Accounts.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end

end
