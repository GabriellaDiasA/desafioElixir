defmodule DesafioElixirAPI.User.Delete do
  @moduledoc """
  Handles all user deletions.
  """

  alias DesafioElixirAPI.Repo

  def delete(user) do
    case Repo.delete(user) do
      {:error, _changeset} -> {:error, "User not found"}
      {:ok, struct} -> {:ok, struct}
    end
  end
end
