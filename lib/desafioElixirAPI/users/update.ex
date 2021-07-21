defmodule DesafioElixirAPI.User.Update do
  @moduledoc """
  Handles all user updates.
  """

  alias DesafioElixirAPI.{Repo, User}

  def update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = result), do: result
  defp handle_insert({:error, result}), do: {:error, %{result: result, status: :bad_request}}

end
