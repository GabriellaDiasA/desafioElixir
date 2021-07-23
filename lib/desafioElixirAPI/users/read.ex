defmodule DesafioElixirAPI.User.Read do
  @moduledoc """
  Handles all user Read requests.
  """

  alias DesafioElixirAPI.{Repo, User}

  def show_one(uuid) do
    with {:ok, uuid} <- Ecto.UUID.cast(uuid),
         result when not is_nil(result) <- Repo.get(User, uuid) do
      {:ok, result}
    else
      :error -> {:error, "Invalid UUID"}
      nil -> {:error, "User doesn't exist"}
    end
  end

  def show_all() do
    case Repo.all(User) do
      [] -> {:error, "No users registered"}
      users -> {:ok, users}
    end
  end
end
