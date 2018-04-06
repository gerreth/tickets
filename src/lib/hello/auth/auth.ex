defmodule Hello.Auth do
  alias Hello.Accounts.User
  alias Hello.Auth.Encryption
  alias Hello.Repo

  @doc """
  Normal pattern
  """
  def login(params = %{"email" => email, "password" => password}) do
    login(email, password)
  end

  @doc """
  GraphQL pattern
  """
  def login(params = %{:email => email, :password => password}) do
    login(email, password)
  end

  def login(email, password) do
    user = Repo.get_by(User, email: email)
    case authenticate(user, password) do
      true  -> {:ok, user}
      _     -> :error
    end
  end

  def login_with_email_pass(email, pass) do
    user = Hello.Repo.get_by(User, email: String.downcase(email))
    case authenticate(user, pass) do
      true  -> {:ok, user}
      _     -> :error
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
