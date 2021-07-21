defmodule DesafioElixirAPI.Operation.Update do
  @moduledoc """
  Handles all operation updates.
  """

  alias DesafioElixirAPI.{Repo, Operation}

  def update(operation, params) do
    operation
    |> Operation.changeset(params)
    |> Repo.update()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Operation{}} = result), do: result
  defp handle_insert({:error, result}), do: {:error, %{result: result, status: :bad_request}}

end
