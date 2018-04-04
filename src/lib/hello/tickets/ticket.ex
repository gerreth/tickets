defmodule Hello.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tickets" do
    field :body, :string
    field :priority, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:title, :body, :priority])
    |> validate_required([:title, :body, :priority])
  end
end
