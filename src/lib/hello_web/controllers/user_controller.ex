defmodule HelloWeb.UserController do
  use HelloWeb, :controller

  alias Hello.Accounts
  alias Hello.Accounts.User
  alias Hello.Auth.Guardian

  def index(conn, _params) do
    users = Accounts.list_users(false)  # user.deleted == true/false
    inactive_users = Accounts.list_users(true)  # user.deleted == true/false
    render(conn, "index.html", users: users, inactive_users: inactive_users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> Guardian.Plug.sign_in(user)
        |> put_session(:current_user, user.id)
        |> redirect(to: user_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end

  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def toggle_status(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, user} = Accounts.toggle_user_deleted(user)

    conn
    |> put_flash(:info, "User #{user.deleted && 'deactivated' || 'activated'} successfully.")
    |> redirect(to: user_path(conn, :index))
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
