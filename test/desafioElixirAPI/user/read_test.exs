defmodule DesafioElixirAPI.User.ReadTest do
  use DesafioElixirAPI.DataCase

  alias DesafioElixirAPI.User
  alias DesafioElixirAPI.User.Create
  alias DesafioElixirAPI.User.Read

  @params1 %{
    name: "Gabriella Dias",
    password: "thepassword",
    email: "gabriella.dias@gmail.com"
  }

  @params2 %{
    name: "Nicolle Seraphim",
    password: "theotherpassword",
    email: "nicolle.seraphim@gmail.com"
  }

  describe "show_all/0" do
    test "when there are users registered, return a list containing User structs" do
      {:ok, %User{id: user1_id}} = Create.create(@params1)
      {:ok, %User{id: user2_id}} = Create.create(@params2)

      {:ok, users} = Read.show_all()

      assert [%User{name: "Gabriella Dias", id: ^user1_id}, %User{name: "Nicolle Seraphim", id: ^user2_id}] = users
    end

    test "when there are no users registered, returns an error with a message" do
      response = Read.show_all()

      assert {:error, "No users registered"} = response
    end
  end

  describe "show_one/1" do
    test "when a valid UUID is passed, return the user" do
      {:ok, %User{id: user_id}} = Create.create(@params1)
      user = Repo.get(User, user_id)

      response = Read.show_one(user_id)

      assert {:ok, ^user} = response
    end

    test "when an invalid UUID is passed, returns an error message" do
      {:ok, %User{id: user_id}} = Create.create(@params1)
      user = Repo.get(User, user_id)
      {:ok, _struct} = Repo.delete(user)

      response = Read.show_one(user_id)

      assert {:error, "Invalid UUID"} = response
    end
  end
end
