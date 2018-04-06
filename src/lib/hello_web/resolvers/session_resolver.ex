defmodule HelloWeb.SessionResolver do

  def login(args = %{email: email, password: password}, _info) do
    with {:ok, user} <- Hello.Auth.login(args),
         {:ok, jwt, _} <- Hello.Auth.Guardian.encode_and_sign(user),
         {:ok, _ } <- Hello.Accounts.store_token(user, jwt) do
      {:ok, %{token: jwt}}
    end
  end

  def logout(args = %{id: id, token: token}, _info) do
    """
    TODO: General. If id not found => error
    """
    user = Hello.Accounts.get_user!(id)
    Hello.Accounts.revoke_token(user, nil)
    {:ok, user}
  end

  def logout(args = %{id: id}, _info) do
    {:error, "Please provide token!"}
  end

  def logout(_args, _info) do
    {:error, "Please log in first!"}
  end
end
