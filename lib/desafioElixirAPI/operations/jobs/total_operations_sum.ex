defmodule DesafioElixirAPI.Operation.Jobs.TotalOperationsSum do
  use Oban.Worker, queue: :default, max_attempts: 4

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"amount" => amount} = args}) do
    IO.inspect(amount)
    :ok
  end
end
