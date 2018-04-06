defmodule HelloWeb.SessionResolver do

  def login(args = %{email: email, password: password}, _info) do
    with {:ok, user} <- Hello.Auth.login(args),
         {:ok, jwt, _} <- Hello.Auth.Guardian.encode_and_sign(user),
         {:ok, _ } <- Hello.Accounts.update_token(user, jwt) do
      {:ok, %{token: jwt, id: user.id}}
    end
  end

  def logged_in?(id) do
    
  end

  def logout(args = %{id: id, token: token}, _info) do
    case Hello.Accounts.get_user(id) do
      :error -> {:error, "User not found"}
      user -> Hello.Accounts.update_token(user, nil)
    end

  end

  def logout(args = %{id: id}, _info) do
    {:error, "Please provide token!"}
  end

  def logout(_args, _info) do
    {:error, "Please log in first!"}
  end
end
