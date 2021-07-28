defmodule DesafioElixirAPI.User.UpdateTest do
  use DesafioElixirAPI.DataCase

  alias DesafioElixirAPI.User
  alias DesafioElixirAPI.User.Create
  alias DesafioElixirAPI.User.Update

  @params1 %{
    name: "Gabriella Dias",
    password: "thepassword",
    email: "gabriella.dias@gmail.com"
  }

  @params2 %{
    name: "Nicolle Seraphim",
    password: "thenewpassword",
    email: "nicolle.seraphim@gmail.com"
  }

  @invalid_params %{
    password: "thepassword",
    email: "gabriella.diasgmail.com"
  }

  describe "update/2" do
    test "when user exists and params are valid, return the updated user with updated params" do
      {:ok, %User{id: user_id}} = Create.create(@params1)
      user = Repo.get(User, user_id)

      {:ok, updated_user} = Update.update(user, @params2)

      assert %User{name: "Nicolle Seraphim", id: ^user_id} = updated_user
    end

    test "when params are invalid, returns an error with a changeset" do
      {:ok, %User{id: user_id}} = Create.create(@params1)
      user = Repo.get(User, user_id)

      {:error, changeset} = Update.update(user, @invalid_params)

      expected_response = %{
        email: ["has invalid format"]
      }

      assert errors_on(changeset) == expected_response
    end

  end
end
