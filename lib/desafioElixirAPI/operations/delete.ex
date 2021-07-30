defmodule DesafioElixirAPI.Operation.Delete do
  @moduledoc """
  Handles all operation deletions.
  """

  alias DesafioElixirAPI.Repo

  def delete(operation) do
    case Repo.delete(operation) do
      {:error, _changeset} -> {:error, %{result: "Invalid UUID", status: :bad_request}}
      {:ok, struct} -> {:ok, struct}
    end
  end
end
