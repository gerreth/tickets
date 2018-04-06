defmodule HelloWeb.Schema do
  use Absinthe.Schema

  alias HelloWeb.TicketsResolver
  alias HelloWeb.SessionResolver

  object :ticket do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :priority, non_null(:string)
  end

  object :session do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :token, non_null(:string)
  end

  query do
    field :login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&SessionResolver.login/2)
    end

    field :ticket, :ticket do
      arg :id, non_null(:id)
      resolve &TicketsResolver.ticket/3
    end

    field :tickets, non_null(list_of(non_null(:ticket))) do
      resolve &TicketsResolver.tickets/3
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

      resolve &TicketsResolver.create_ticket/3
    end
  end
end
