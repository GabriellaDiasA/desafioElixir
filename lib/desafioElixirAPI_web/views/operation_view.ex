defmodule DesafioElixirAPIWeb.OperationView do
  @moduledoc """
  Handles rendering Operation info for the user.
  """

  use DesafioElixirAPIWeb, :view

  def render("create.json", %{multi: multi}) do
    %{
      message: "operation created.",
      multi: multi
    }
  end

  def render("read.json", %{operations: operations}) do
    %{
      message: "listing all operations.",
      operations: operations
    }
  end

  def render("read.json", %{operation: operation}) do
    %{
      message: "displaying operation.",
      operation: operation
    }
  end

  def render("update.json", %{operation: operation}) do
    %{
      message: "operation updated.",
      operation: operation
    }
  end

  def render("delete.json", _) do
    %{
      message: "operation deleted."
    }
  end
end
