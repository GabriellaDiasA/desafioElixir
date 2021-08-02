defmodule DesafioElixirAPIWeb.SessionController do
  @moduledoc """
  Handles all Session-related HTTP requests.
  """

  use DesafioElixirAPIWeb, :controller

  alias DesafioElixirAPIWeb.FallbackController
  alias DesafioElixirAPI.User

  action_fallback FallbackController

  def create_token(conn, %{"id" => uuid}) do
    with {:ok, %User{} = user} <- DesafioElixirAPI.read_user(uuid),
         {:ok, token, _claims} <- DesafioElixirAPI.create_session(user) do
      conn
      |> put_status(:ok)
      |> render("create.json", %{user: user, token: token})
    end
  end
end
