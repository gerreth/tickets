defmodule Hello.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Auth.Encryption
  alias Hello.Tickets.Ticket

  schema "users" do
    field :username, :string
    field :email, :string
    field :password_hash, :string
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
    |> validate_email
    # constraints
    |> unique_constraint(:username)
    # put in correct format
    |> downcase_email
    |> encrypt_password
  end

  def validate_email(changeset) do
    format = ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
    message = "Provide valid Email"
    validate_format(changeset, :email, format, message: message)
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)

    if password do
      encrypted_password = Encryption.hash_password(password)
      put_change(changeset, :password_hash, encrypted_password)
    else
      changeset
    end
  end

  def downcase_email(changeset) do
    update_change(changeset, :email, &String.downcase/1)
  end
end
