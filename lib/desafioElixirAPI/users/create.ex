defmodule DesafioElixirAPI.User.Create do
  @moduledoc """
  Handles all user creations.
  """

  alias DesafioElixirAPI.{Repo, User}
  alias Ecto.Changeset

  def create(params) do
    if !params["balance"] do
      params
      |> User.changeset()
      |> Repo.insert()
      |> handle_insert()
    end
  end

  defp handle_insert({:ok, %User{}} = result), do: result
  defp handle_insert({:error, %Changeset{}} = result), do: result
end
