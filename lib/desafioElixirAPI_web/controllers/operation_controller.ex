defmodule DesafioElixirAPIWeb.OperationController do
  @moduledoc """
  Handles all Operation-related HTTP requests.
  """

  use DesafioElixirAPIWeb, :controller

  alias DesafioElixirAPI.{Operation, User}
  alias DesafioElixirAPIWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, user} <- DesafioElixirAPI.read_user(params["origin_id"]),
         :ok <- DesafioElixirAPI.verify_token_ownership(user, conn),
         {:ok, multi} <- DesafioElixirAPI.create_operation(params) do
      conn
      |> put_status(:ok)
      |> render("create.json", multi: multi)
    end
  end

  def show_all(conn, _params) do
    with {:ok, operations = operations} <- DesafioElixirAPI.read_all_operation() do
      conn
      |> put_status(:ok)
      |> render("read.json", operations: operations)
    end
  end

  def show_one(conn, %{"id" => uuid}) do
    with {:ok, %Operation{} = operation} <- DesafioElixirAPI.read_operation(uuid) do
      conn
      |> put_status(:ok)
      |> render("read.json", operation: operation)
    end
  end

  def update(conn, params) do
    with {:ok, operation} <- DesafioElixirAPI.read_operation(params["id"]),
         {:ok, user} <- DesafioElixirAPI.read_user(params["origin_id"]),
         :ok <- DesafioElixirAPI.verify_token_ownership(user, conn),
         {:ok, %Operation{} = operation} <- DesafioElixirAPI.edit_operation(operation, params) do
      conn
      |> put_status(:ok)
      |> render("update.json", operation: operation)
    end
  end

  def delete(conn, params) do
    with {:ok, operation} = DesafioElixirAPI.read_operation(params["id"]),
         {:ok, user} <- DesafioElixirAPI.read_user(operation.origin_id),
         :ok <- DesafioElixirAPI.verify_token_ownership(user, conn),
         {:ok, %Operation{} = _operation} <- DesafioElixirAPI.delete_operation(operation) do
      conn
      |> put_status(:ok)
      |> render("delete.json")
    end
  end
end
