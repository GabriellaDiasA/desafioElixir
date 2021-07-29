defmodule DesafioElixirAPI.User.CreateTest do
  use DesafioElixirAPI.DataCase, async: true

  alias DesafioElixirAPI.User
  alias DesafioElixirAPI.User.Create

  @valid_params %{
    name: "Gabriella Dias",
    password: "thepassword",
    email: "gabriella.dias@gmail.com"
  }

  @invalid_params %{
    name: "Gabriella Dias",
    email: "gabriella.dias@gmail.com"
  }

  describe "create/1" do
    test "when all params are valid, returns a user" do
      {:ok, %User{id: user_id}} = Create.create(@valid_params)
      user = Repo.get(User, user_id)

      assert %User{name: "Gabriella Dias", id: ^user_id} = user
    end

    test "when params are invalid, returns an error with a changeset" do
      {:error, changeset} = Create.create(@invalid_params)

      expected_response = %{
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
