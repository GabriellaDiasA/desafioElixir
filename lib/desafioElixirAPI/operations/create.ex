defmodule DesafioElixirAPI.Operation.Create do
  @moduledoc """
  Creates a new financial operation.
  """

  alias DesafioElixirAPI.{Repo, Operation, User}
  alias Ecto.Multi
  alias DesafioElixirAPI.Operation.Jobs.TotalOperationsSum

  import Ecto.Query

  def create(params) do
    operation_changeset = Operation.changeset(params)

    if operation_changeset.valid? == true do
      if params["destination_id"] == nil do
        withdraw(params, operation_changeset)
      else
        transfer(params, operation_changeset)
      end
    else
      {:error, operation_changeset}
    end
  end

  defp withdraw(params, operation_changeset) do
    case DesafioElixirAPI.read_user(params["origin_id"]) do
      {:ok, user} ->
        new_balance = user.balance - params["amount"]
        Multi.new()
        |> Multi.update(:edit_user, User.edit_changeset(user, %{"balance" => new_balance}))
        |> Multi.insert(:create_operation, operation_changeset)
        |> Multi.run(:worker_routine, fn _repo, map -> apply_job(map) end)
        |> Multi.run(:lock_rows, fn _repo, map -> lock_user(map) end)
        |> Repo.transaction()
      {:error, "Invalid UUID"} -> {:error, operation_changeset}
    end
  end

  defp transfer(params, operation_changeset) do
    with {:ok, origin} <- DesafioElixirAPI.read_user(params["origin_id"]),
         {:ok, destination} <- DesafioElixirAPI.read_user(params["destination_id"]) do

    new_origin_balance = origin.balance - params["amount"]
    new_destination_balance = destination.balance + params["amount"]

    Multi.new()
    |> Multi.update(:edit_origin, User.edit_changeset(origin, %{"balance" => new_origin_balance}))
    |> Multi.update(:edit_destination, User.edit_changeset(destination, %{"balance" => new_destination_balance}))
    |> Multi.insert(:create_operation, operation_changeset)
    |> Multi.run(:worker_routine, fn _repo, map -> apply_job(map) end)
    |> Multi.run(:lock_rows, fn _repo, map -> lock_origin_and_destination(map) end)
    |> Repo.transaction()
    else
      _ -> {:error, operation_changeset}
    end
  end

  defp apply_job(%{create_operation: %Operation{amount: amount}}) do
    %{"amount" => amount}
    |> TotalOperationsSum.new()
    |> Oban.insert()
    {:ok, :ok}
  end

  defp lock_user(%{edit_user: %User{id: id}}), do: lock_user(id)

  defp lock_user(id) do
    user = from(u in User, where: u.id == ^id, lock: "FOR UPDATE")
    |> Repo.one()
    {:ok, :ok}
  end

  defp lock_origin_and_destination(%{edit_origin: %User{id: origin_id}, edit_destination: %User{id: destination_id}}) do
    lock_user(origin_id)
    lock_user(destination_id)

    {:ok, :ok}
  end
end
