defmodule Hello.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do

      add :username, :string
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

  end

end
