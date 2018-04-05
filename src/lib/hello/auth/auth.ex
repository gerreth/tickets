defmodule Hello.Auth do
  alias Hello.Accounts.User
  alias Hello.Auth.Encryption

  def login(params, repo) do
    user = repo.get_by(User, email: String.downcase(params["email"]))
    case authenticate(user, params["password"]) do
      true  -> {:ok, user}
      _     -> {:error, "Incorrect username or password"}
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Encryption.validate_password(password, user.password_hash)
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Hello.Repo.get(User, id)
  end

  def logged_in?(conn), do: !!current_user(conn)
end
