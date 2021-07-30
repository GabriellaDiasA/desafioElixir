defmodule DesafioElixirAPI.Operation.Jobs.GenerateNewOperations do
  use Oban.Worker, queue: :default, max_attempts: 4

  alias DesafioElixirAPI.{Repo, User}

  @impl Oban.Worker
  def perform(_job) do
    randomize_params()
    |> DesafioElixirAPI.create_operation()

    :ok
  end

  defp randomize_params do
    origin = pick_user()
    destination_or_nil = pick_destination(origin)
    amount = pick_amount(origin)

    %{
      "origin_id" => origin.id,
      "destination_id" => destination_or_nil,
      "amount" => amount
    }
  end

  defp pick_user do
    User
    |> Repo.all()
    |> Enum.random()
  end

  defp pick_destination(user) do
    attempt = pick_user()
    if attempt != user do
      attempt.id
    else
      nil
    end
  end

  defp pick_amount(user) do
    amount = Enum.random(1..trunc(user.balance))
    amount = Enum.random(1..amount)
    amount = Enum.random(1..amount)
    amount = Enum.random(1..amount)
    amount / 1
  end

end
