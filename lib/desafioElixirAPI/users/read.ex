defmodule DesafioElixirAPI.User.Read do
  @moduledoc """
  Handles all user Read requests.
  """

  alias DesafioElixirAPI.{Repo, User}

  def show_one(uuid) do
    with user <- Repo.get(User, uuid),
         {:ok, _binary} <- Ecto.UUID.dump(uuid) do
      case user do
        nil -> {:error, "Invalid UUID"}
        user -> {:ok, user}
      end
    else
      _ -> {:error, "Invalid UUID"}
    end
  end

  def show_all() do
    case Repo.all(User) do
      [] -> {:error, "No users registered"}
      users -> {:ok, users}
    end
  end
end
