defmodule DesafioElixirAPIWeb.OperationController do
  @moduledoc """
  Handles all Operation-related HTTP requests.
  """

  use DesafioElixirAPIWeb, :controller

  alias DesafioElixirAPI.{Operation, User}
  alias DesafioElixirAPIWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    {:ok, origin} = DesafioElixirAPI.read_user(params["origin_id"])
    if is_nil(params["destination_id"]) do
      withdrawl(conn, params, origin)
    else
      {:ok, destination} = DesafioElixirAPI.read_user(params["destination_id"])
      transfer(conn, params, destination, origin)
    end
  end

  defp transfer(conn, params, destination, origin) do
    new_destination_balance = destination.balance + params["amount"]
    new_origin_balance = origin.balance - params["amount"]
    with {:ok, %User{} = _user} <- DesafioElixirAPI.edit_user(origin, %{"balance" => new_origin_balance}) do
      DesafioElixirAPI.edit_user(destination, %{"balance" => new_destination_balance})
      with {:ok, %Operation{} = operation} <- DesafioElixirAPI.create_operation(params) do
        conn
        |> put_status(:ok)
        |> render("create.json", operation: operation)
      end
    end
  end

  defp withdrawl(conn, params, origin) do
    new_origin_balance = origin.balance - params["amount"]
    with {:ok, %User{} = _user} <- DesafioElixirAPI.edit_user(origin, %{"balance" => new_origin_balance}) do
      with {:ok, %Operation{} = operation} <- DesafioElixirAPI.create_operation(params) do
        conn
        |> put_status(:ok)
        |> render("create.json", operation: operation)
      end
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
    {:ok, operation} = DesafioElixirAPI.read_operation(params["id"])
    with {:ok, %Operation{} = operation} <- DesafioElixirAPI.edit_operation(operation, params) do
      conn
      |> put_status(:ok)
      |> render("update.json", operation: operation)
    end
  end

  def delete(conn, params) do
    {:ok, operation} = DesafioElixirAPI.read_operation(params["id"])
    with {:ok, %Operation{} = _operation} <- DesafioElixirAPI.delete_operation(operation) do
      conn
      |> put_status(:ok)
      |> render("delete.json")
    end
  end
end
