defmodule DesafioElixirAPI.WeeklySum.Read do
  @moduledoc """
  Handles all Weekly Sum Read requests.
  """

  alias DesafioElixirAPI.{Repo, WeeklySum}

  def show_all() do
    case Repo.all(WeeklySum) do
      [] -> {:error, "No entries registered"}
      result -> {:ok, result}
    end
  end
end
