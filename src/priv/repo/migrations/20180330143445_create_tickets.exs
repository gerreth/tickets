defmodule Hello.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :title, :string
      add :body, :string
      add :priority, :string

      timestamps()
    end

  end
end
