defmodule HelloWeb.TicketsResolver do
  alias Hello.Tickets

  def all_tickets(_root, _args, _info) do
    tickets = Tickets.list_tickets()
    {:ok, tickets}
  end

  def create_ticket(_root, args, _info) do
    # TODO: add detailed error message handling later
    case Tickets.create_ticket(args) do
      {:ok, ticket} ->
        {:ok, ticket}
      _error ->
        {:error, "could not create ticket"}
    end
  end

end
