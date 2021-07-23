defmodule DesafioElixirAPIWeb.UserController do
  @moduledoc """
  Handles all User-related HTTP requests.
  """

  use DesafioElixirAPIWeb, :controller

  alias DesafioElixirAPI.User
  alias DesafioElixirAPIWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- DesafioElixirAPI.create_user(params) do
      conn
      |> put_status(:ok)
      |> render("create.json", %{user: user})
    end
  end

  def index(conn, _params) do
    with {:ok, users = users} <- DesafioElixirAPI.read_all_user() do
      conn
      |> put_status(:ok)
      |> render("read.json", users: users)
    end
  end

  def show(conn, %{"id" => uuid}) do
    with {:ok, %User{} = user} <- DesafioElixirAPI.read_user(uuid) do
      conn
      |> put_status(:ok)
      |> render("read.json", user: user)
    end
  end

  def update(conn, %{"id" => uuid} = params) do
    with {:ok, user} <- DesafioElixirAPI.read_user(uuid) |> IO.inspect(),
         {:ok, %User{} = user} <- DesafioElixirAPI.edit_user(user, params) do
      conn
      |> put_status(:ok)
      |> render("update.json", user: user)
    end
  end

  def delete(conn, %{"id" => uuid}) do
    with {:ok, user} <- DesafioElixirAPI.read_user(uuid),
         {:ok, %User{} = _user} <- DesafioElixirAPI.delete_user(user) do
      conn
      |> put_status(:ok)
      |> render("delete.json")
    end
  end
end
