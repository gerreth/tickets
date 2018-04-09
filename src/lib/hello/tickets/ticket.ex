import EctoEnum

defenum PriorityEnum, :priority, [:low, :medium, :high]
defenum StatusEnum, :status, [:created, :started, :finished, :accepted]

defmodule Hello.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Tickets.Ticket.Helper

  schema "tickets" do
    field :body, :string
    field :priority, PriorityEnum, default: :low
    field :title, :string
    field :status, StatusEnum, default: :created
    field :deleted, :boolean, null: false, default: false
    # Relationships
    belongs_to :users, Hello.Accounts.User, foreign_key: :user_id

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
    # custom
    |> Helper.append_user_id(attrs)
  end

end
