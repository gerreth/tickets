defmodule Hello.Accounts.User.Helper do

  import Ecto.Changeset

  alias Hello.Auth.Encryption
  alias Hello.Accounts.User

  def store_token_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:token])
  end

  def validate_email(changeset) do
    format = ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
    message = "Provide valid Email"
    validate_format(changeset, :email, format, message: message)
  end

  def encrypt_password(changeset) do
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
