defmodule DesafioElixirAPI.Operation.Create do
  @moduledoc """
  Creates a new financial operation.
  """

  alias DesafioElixirAPI.{Repo, Operation}

  def create(params) do
    params
    |> Operation.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Operation{}} = result), do: result
  defp handle_insert({:error, result}), do: {:error, %{result: result, status: :bad_request}}
end
