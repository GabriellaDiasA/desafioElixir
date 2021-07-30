defmodule DesafioElixirAPI.User.Update do
  @moduledoc """
  Handles all user updates.
  """

  alias DesafioElixirAPI.{Repo, User}
  alias Ecto.Multi

  import Ecto.Query

  def update(user, params) do
    Multi.new()
    |> Multi.run(:lock_user, fn _repo, _map -> lock_user(user.id) end)
    |> Multi.update(:edit_user, User.edit_changeset(user, params))
    |> Repo.transaction()
    |> handle_insert()
  end

  defp lock_user(id) do
    user = from(u in User, where: u.id == ^id, lock: "FOR UPDATE")
    {:ok, :ok}
  end

  defp handle_insert({:ok, result}), do: {:ok, result}
  defp handle_insert({:error, result}), do: {:error, result}

end
