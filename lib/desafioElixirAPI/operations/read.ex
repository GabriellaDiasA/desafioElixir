defmodule DesafioElixirAPI.Operation.Read do
  @moduledoc """
  Provides all functions to do with Reading entries in the Operation table.
  """

  alias DesafioElixirAPI.{Repo, Operation}

  def show_one(uuid) do
    case Repo.get(Operation, uuid) do
      nil -> {:error, %{result: "Invalid UUID", status: :bad_request}}
      operation -> {:ok, operation}
    end
  end

  def show_all() do
    case Repo.all(Operation) do
      nil -> {:error, "No operations registered"}
      operations -> {:ok, operations}
    end
  end
end
