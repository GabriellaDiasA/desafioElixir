defmodule DesafioElixirAPIWeb.UserController do
  @moduledoc """
  Handles all User-related HTTP requests.
  """

  use DesafioElixirAPIWeb, :controller

  alias DesafioElixirAPI.User
  alias DesafioElixirAPIWeb.FallbackController
  alias DesafioElixirAPI.Guardian

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- DesafioElixirAPI.create_user(params) do
      conn
      |> put_status(:ok)
      |> render("create.json", user: user)
    end
  end

  def show_all(conn, _params) do
    with {:ok, users = users} <- DesafioElixirAPI.read_all_user() do
      conn
      |> put_status(:ok)
      |> render("read.json", users: users)
    end
  end

  def show_one(conn, %{"id" => uuid}) do
    with {:ok, %User{} = user} <- DesafioElixirAPI.read_user(uuid) do
      conn
      |> put_status(:ok)
      |> render("read.json", user: user)
    end
  end

  def update(conn, params) do
    with {:ok, user} <- DesafioElixirAPI.read_user(params["id"]),
         {:ok, multi} <- DesafioElixirAPI.edit_user(user, params) do
      conn
      |> put_status(:ok)
      |> render("update.json", multi: multi)
    end
  end

  def delete(conn, params) do
    {:ok, user} = DesafioElixirAPI.read_user(params["id"])
    with {:ok, %User{} = _user} <- DesafioElixirAPI.delete_user(user) do
      conn
      |> put_status(:ok)
      |> render("delete.json")
    end
  end
end
