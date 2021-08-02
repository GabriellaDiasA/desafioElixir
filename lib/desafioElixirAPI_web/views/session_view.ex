defmodule DesafioElixirAPIWeb.SessionView do
  @moduledoc """
  Handles rendering Session info for the user.
  """

  use DesafioElixirAPIWeb, :view

  def render("create.json", %{user: user, token: token}) do
    %{
      message: "token generated.",
      user: user,
      token: token
    }
  end
end
