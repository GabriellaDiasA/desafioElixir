defmodule DesafioElixirAPI.User.CreateTest do
  use DesafioElixirAPI.DataCase

  alias DesafioElixirAPI.User
  alias DesafioElixirAPI.User.Create

  describe "create/1" do
    test "when all params are valid, returns a user" do
      params = %{
        name: "Gabriella Dias",
        password: "thepassword",
        email: "gabriella.dias@gmail.com"
      }

      {:ok, %User{id: user_id}} = Create.create(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Gabriella Dias", id: ^user_id} = user

    end

    test "when params are invalid, returns an error with a changeset" do
      params = %{
        name: "Gabriella Dias",
        email: "gabriella.dias@gmail.com"
      }

      {:error, changeset} = Create.create(params)

      expected_response = %{
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end

  end
end
