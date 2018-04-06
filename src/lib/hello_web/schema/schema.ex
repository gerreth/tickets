defmodule HelloWeb.Schema do
  use Absinthe.Schema
  import_types Hello.Web.Schema.Types

  alias HelloWeb.SessionResolver
  alias HelloWeb.TicketResolver
  alias HelloWeb.UserResolver

  query do
    field :login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&SessionResolver.login/2)
    end

    field :ticket, :ticket do
      arg :id, non_null(:id)
      resolve &TicketResolver.ticket/3
    end

    field :tickets, non_null(list_of(non_null(:ticket))) do
      resolve &TicketResolver.tickets/3
    end

    field :user, :user do
      arg :id, non_null(:id)
      resolve &UserResolver.user/3
    end

    field :users, non_null(list_of(non_null(:user))) do
      resolve &UserResolver.users/3
    end
  end

  mutation do
    field :logout, :session do
      arg(:id, non_null(:id))
      arg(:token, non_null(:string))

      resolve(&SessionResolver.logout/2)
    end

    field :create_ticket, :ticket do
      arg :title, non_null(:string)
      arg :body, non_null(:string)
      arg :priority, non_null(:string)

      resolve &TicketResolver.create_ticket/3
    end
  end
end
