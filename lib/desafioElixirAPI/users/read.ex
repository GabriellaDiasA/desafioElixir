defmodule DesafioElixirAPI.User.Read do
  @moduledoc """
  Handles all user Read requests.
  """

  alias DesafioElixirAPI.{Repo, User}

  def show_one(uuid) do
    if is_nil(uuid) do
      :error
    end
    case Repo.get(User, uuid) do
      nil -> {:error, %{result: "Invalid UUID", status: :bad_request}}
      user -> {:ok, user}
    end
  end

  def show_all() do
    case Repo.all(User) do
      nil -> {:error, "No users registered"}
      users -> {:ok, users}
    end
  end
end
