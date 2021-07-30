defmodule DesafioElixirAPI.DailySum.Read do
  @moduledoc """
  Handles all Daily Sum Read requests.
  """

  alias DesafioElixirAPI.{Repo, DailySum}

  def show_all() do
    case Repo.all(DailySum) do
      [] -> {:error, "No entries registered"}
      result -> {:ok, result}
    end
  end
end
