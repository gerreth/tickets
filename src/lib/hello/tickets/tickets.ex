defmodule Hello.Tickets do
  @moduledoc """
  The Tickets context.
  """

  import Ecto.Query, warn: false

  alias Hello.Repo
  alias Hello.Tickets.Ticket

  @doc false
  def list_tickets do
    Repo.all(Ticket)
  end

  @doc false
  def get_ticket!(id) do
    Repo.get!(Ticket, id)
  end

  @doc false
  def get_ticket(id) do
    case Repo.get(Ticket, id) do
      nil -> :error
      ticket -> ticket
    end
  end

  @doc false
  def create_ticket(attrs = %{"body" => body, "title" => title, "priority" => priority}, conn) do
    user_id = Plug.Conn.get_session(conn, :current_user)
    # converts string keys to atoms to be consistent with graphql syntax
    attrs = attrs |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put(acc, String.to_atom(key), val) end)

    insert_ticket(attrs, user_id)
  end

  @doc false
  def create_ticket(attrs = %{:body => body, :title => title, :priority => priority}) do
    insert_ticket(attrs)
  end

  @doc false
  defp insert_ticket(attrs, user_id \\ 1) do
    attrs = Map.merge(attrs, %{:user_id => user_id})
    %Ticket{}
    |> Ticket.changeset(attrs)
    |> Repo.insert()
  end

  @doc false
  def update_ticket(%Ticket{} = ticket, attrs, conn) do
    user_id = Plug.Conn.get_session(conn, :current_user)
    attrs = Map.merge(attrs, %{"user_id" => user_id})
    ticket
    |> Ticket.changeset(attrs)
    |> Repo.update()
  end

  @doc false
  def delete_ticket(%Ticket{} = ticket) do
    Repo.delete(ticket)
  end

  @doc false
  def change_ticket(%Ticket{} = ticket) do
    Ticket.changeset(ticket, %{})
  end
end
