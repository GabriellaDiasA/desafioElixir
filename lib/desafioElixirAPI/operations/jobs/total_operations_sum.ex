defmodule DesafioElixirAPI.Operation.Jobs.TotalOperationsSum do
  use Oban.Worker, queue: :default, max_attempts: 4

  import Ecto.Query, only: [from: 2]

  alias DesafioElixirAPI.Repo

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"amount" => money} = args}) do
    query = from o in "operations",
          where: true,
          select: o.amount
    result = Repo.all(query)
    total = Enum.sum(result ++ [money])
    IO.inspect(total)
    :ok
  end
end
