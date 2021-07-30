defmodule DesafioElixirAPIWeb.BackofficeView do
  @moduledoc """
  Handles rendering Backoffice info for the user.
  """

  use DesafioElixirAPIWeb, :view

  def render("read.json", %{result: result}) do
    %{
      message: "displaying data.",
      data: result
    }
  end
end
