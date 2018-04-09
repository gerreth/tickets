defmodule Hello.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Hello.Accounts.User.Helper
  alias Hello.Tickets.Ticket

  schema "users" do
    field :username, :string, unique: true
    field :email, :string, unique: true
    field :password_hash, :string
    field :token, :string
    field :deleted, :boolean, null: false, default: false
    # Virtual Fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    # Relationships
    has_many :tickets, Ticket

    timestamps()
  end

  @required_fields ~w(email username password password_confirmation)
  @optional_fields ~w()

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required([:username, :email, :password, :password_confirmation])
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    # custom validation
    |> Helper.validate_email
    # constraints
    |> unique_constraint(:username, [message: "Username has already been taken"])
    |> unique_constraint(:email, [message: "Email already exists"])
    # custom format
    |> Helper.downcase_email
    |> Helper.encrypt_password
  end

end
