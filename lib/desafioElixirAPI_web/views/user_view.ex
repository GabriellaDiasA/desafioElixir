defmodule DesafioElixirAPIWeb.UserView do
  @moduledoc """
  Handles rendering User info for the user.
  """

  use DesafioElixirAPIWeb, :view

  def render("create.json", %{user: user}) do
    %{
      message: "user created.",
      user: user
    }
  end

  def render("read.json", %{users: users}) do
    %{
      message: "listing all users.",
      users: users
    }
  end

  def render("read.json", %{user: user}) do
    %{
      message: "displaying user.",
      user: user
    }
  end

  def render("update.json", %{multi: multi}) do
    %{
      message: "user updated.",
      multi: multi
    }
  end

  def render("delete.json", _) do
    %{
      message: "user deleted."
    }
  end
end
