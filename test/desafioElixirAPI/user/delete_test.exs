defmodule DesafioElixirAPI.User.DeleteTest do
  use DesafioElixirAPI.DataCase

  alias DesafioElixirAPI.User
  alias DesafioElixirAPI.User.Create
  alias DesafioElixirAPI.User.Delete

  @valid_params %{
    name: "Gabriella Dias",
    password: "thepassword",
    email: "gabriella.dias@gmail.com"
  }

  describe "delete/1" do
    test "when the user exists, delete and return a success message" do
      {:ok, %User{id: user_id}} = Create.create(@valid_params)
      user = Repo.get(User, user_id)
      response = Delete.delete(user)

      assert {:ok, %User{id: ^user_id}} = response
    end
  end
end
