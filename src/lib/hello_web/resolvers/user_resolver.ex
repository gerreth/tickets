defmodule HelloWeb.UserResolver do
  alias Hello.Accounts

  def user(_root, %{id: id}, _info) do
    case Accounts.get_user(id) do
      :error -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  def users(_root, _args, _info) do
    users = Accounts.list_users(false)  # user.deleted == true/false
    {:ok, users}
  end

end
