defmodule DesafioElixirAPI.User.Delete do
  @moduledoc """
  Handles all user deletions.
  """

  alias DesafioElixirAPI.{Repo, User}

  def delete(user) do
    case Repo.delete(user) do
      {:error, _changeset} -> {:error, %{result: "Invalid UUID", status: :bad_request}}
      {:ok, struct} -> {:ok, struct}
    end
  end
end
