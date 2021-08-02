defmodule DesafioElixirAPI.QtHourSum.Read do
  @moduledoc """
  Handles all Quarter Hour Sum Read requests.
  """

  alias DesafioElixirAPI.{Repo, QtHourSum}

  def show_all() do
    case Repo.all(QtHourSum) do
      [] -> {:error, "No entries registered"}
      result -> {:ok, result}
    end
  end
end
