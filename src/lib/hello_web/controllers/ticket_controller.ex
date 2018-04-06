defmodule HelloWeb.TicketController do
  use HelloWeb, :controller

  alias Hello.Tickets
  alias Hello.Tickets.Ticket

  def index(conn, _params) do
    tickets = Tickets.list_tickets()
    render(conn, "index.html", tickets: tickets)
  end

  def new(conn, _params) do
    changeset = Tickets.change_ticket(%Ticket{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ticket" => ticket_params}) do
    case Tickets.create_ticket(ticket_params, conn) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket created successfully.")
        |> redirect(to: ticket_path(conn, :show, ticket))
      {:auth_error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:auth_error, "No User Id provided (check if logged in before)")
        |> render("new.html", changeset: changeset)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ticket = Tickets.get_ticket!(id)
    render(conn, "show.html", ticket: ticket)
  end

  def edit(conn, %{"id" => id}) do
    ticket = Tickets.get_ticket!(id)
    changeset = Tickets.change_ticket(ticket)
    render(conn, "edit.html", ticket: ticket, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    ticket = Tickets.get_ticket!(id)

    case Tickets.update_ticket(ticket, ticket_params, conn) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket updated successfully.")
        |> redirect(to: ticket_path(conn, :show, ticket))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ticket: ticket, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ticket = Tickets.get_ticket!(id)
    {:ok, _ticket} = Tickets.delete_ticket(ticket)

    conn
    |> put_flash(:info, "Ticket deleted successfully.")
    |> redirect(to: ticket_path(conn, :index))
  end
end
