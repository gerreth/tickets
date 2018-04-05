defmodule Hello.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tickets" do
    field :body, :string
    field :priority, :string
    field :title, :string
    # Relationships
    belongs_to :users, Hello.User, foreign_key: :user_id

    timestamps()
  end

  @required_fields ~w(title body priority user_id)
  @optional_fields ~w()

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required([:title, :body, :priority])
    |> foreign_key_constraint(:users, name: :tickets_user_id_fkey)
    #
    |> append_user_id(attrs)
  end

  defp append_user_id(changeset, %{:body => body, :title => title, :priority => priority, :user_id => user_id}) do
    put_change(changeset, :user_id, user_id)
  end

  defp append_user_id(changeset, attrs) do
    put_change(changeset, :user_id, attrs["user_id"])
  end

end
