defmodule DesafioElixirAPI.Operation.Jobs.DailyOperationsSum do
  use Oban.Worker, queue: :default, max_attempts: 4

  import Ecto.Query

  alias DesafioElixirAPI.{Repo, DailySum}

  @impl Oban.Worker
  def perform(_job) do
    result = Repo.all(from o in "operations",
                  where: o.inserted_at > datetime_add(^NaiveDateTime.utc_now(), -1, "day"),
                  select: o.amount)
    |> Enum.sum()

    %{"amount" => result}
    |> DailySum.changeset()
    |> Repo.insert()

    :ok
  end
end
