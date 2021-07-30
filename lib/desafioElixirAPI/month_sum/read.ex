defmodule DesafioElixirAPI.MonthlySum.Read do
  @moduledoc """
  Handles all Monthly Sum Read requests.
  """

  alias DesafioElixirAPI.{Repo, MonthlySum}

  def show_all() do
    case Repo.all(MonthlySum) do
      [] -> {:error, "No entries registered"}
      result -> {:ok, result}
    end
  end
end
