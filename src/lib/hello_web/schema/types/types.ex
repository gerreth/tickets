defmodule Hello.Web.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Hello.Repo

  object :ticket do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :priority, non_null(:string)
    field :user_id, non_null(:integer)
    # Relationships
    field :user, :user, resolve: assoc(:user)
  end

  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :username, non_null(:string)
    # Relationships
    field :tickets, list_of(:ticket), resolve: assoc(:tickets)
  end

  object :session do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :token, non_null(:string)
  end
end
