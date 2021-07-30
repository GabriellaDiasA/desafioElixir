defmodule DesafioElixirAPIWeb.BackofficeController do
  @moduledoc """
  Handles all Backoffice-related HTTP requests.
  """

  use DesafioElixirAPIWeb, :controller

  alias DesafioElixirAPIWeb.FallbackController

  action_fallback FallbackController

  def show_all_daily(conn, _params) do
    with {:ok, result} <- DesafioElixirAPI.read_all_daily() do
      conn
      |> put_status(:ok)
      |> render("read.json", result: result)
    end
  end

  def show_all_weekly(conn, _params) do
    with {:ok, result} <- DesafioElixirAPI.read_all_weekly() do
      conn
      |> put_status(:ok)
      |> render("read.json", result: result)
    end
  end

  def show_all_monthly(conn, _params) do
    with {:ok, result} <- DesafioElixirAPI.read_all_monthly() do
      conn
      |> put_status(:ok)
      |> render("read.json", result: result)
    end
  end

  def show_all_qt_hour(conn, _params) do
    with {:ok, result} <- DesafioElixirAPI.read_all_qt_hour() do
      conn
      |> put_status(:ok)
      |> render("read.json", result: result)
    end
  end
end
