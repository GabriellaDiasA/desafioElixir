defmodule DesafioElixirAPIWeb.FallbackController do
  @moduledoc """
  Handles all requests that return errors.
  """

  use DesafioElixirAPIWeb, :controller

  alias DesafioElixirAPIWeb.ErrorView

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
