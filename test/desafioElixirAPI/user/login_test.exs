defmodule DesafioElixirAPI.User.ReadTest do
  use DesafioElixirAPI.DataCase

  alias DesafioElixirAPI.User
  alias DesafioElixirAPI.User.Create
  alias DesafioElixirAPI.User.Read
  alias DesafioElixirAPI.Guardian

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
    test "Guardian pls help" do
      {:ok, %User{id: user1_id} = user1} = Create.create(@params1)
      {:ok, %User{id: user2_id}} = Create.create(@params2)

      {:ok, users} = Read.show_all()

      {:ok, token, claims} = Guardian.encode_and_sign(user1)
      IO.inspect(token)
      IO.inspect(claims)

      assert [%User{name: "Gabriella Dias", id: ^user1_id}, %User{name: "Nicolle Seraphim", id: ^user2_id}] = users
    end
  end
end
