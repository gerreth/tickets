defmodule Hello.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Hello.Repo

  alias Hello.Accounts.User

  @doc false
  def update_token(%User{} = user, token) do
    user
    |> Hello.Accounts.User.Helper.store_token_changeset(%{token: token})
    |> Repo.update()

    {:ok, user}
  end

  @doc false
  def list_users do
    Repo.all(User)
  end

  @doc false
  def get_user!(id), do: Repo.get!(User, id)

  @doc false
  def get_user(id) do
    case Repo.get(User, id) do
      nil -> :error
      user -> user
    end
  end

  @doc false
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc false
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc false
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc false
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
