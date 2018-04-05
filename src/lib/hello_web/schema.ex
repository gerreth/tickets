defmodule HelloWeb.Schema do
  use Absinthe.Schema

  alias HelloWeb.TicketsResolver

  object :ticket do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :priority, non_null(:string)
  end

  query do
    field :all_tickets, non_null(list_of(non_null(:ticket))) do
      resolve &TicketsResolver.all_tickets/3
    end
  end

  mutation do
    field :create_ticket, :ticket do
      arg :title, non_null(:string)
      arg :body, non_null(:string)
      arg :priority, non_null(:string)

      resolve &TicketsResolver.create_ticket/3
    end
  end
end
