defmodule Hello.Tickets.Ticket.Helper do

  import Ecto.Changeset

  def append_user_id(changeset, %{:body => body, :title => title, :priority => priority, :user_id => user_id}) do
    put_change(changeset, :user_id, user_id)
  end

  def append_user_id(changeset, attrs) do
    put_change(changeset, :user_id, attrs["user_id"])
  end
  
end
