defmodule DesafioElixirAPI.Operation.CreateTest do
  use DesafioElixirAPI.DataCase

  alias DesafioElixirAPI.User
  alias DesafioElixirAPI.Operation

  @valid_user1 %{
    name: "Gabriella Dias",
    password: "thepassword",
    email: "gabriella.dias@gmail.com"
  }

  @valid_user2 %{
    name: "Nicolle Seraphim",
    password: "theotherpassword",
    email: "nicolle.seraphim@gmail.com"
  }

  @invalid_user1 %{
    name: "Gabriella Dias",
    password: "12354678",
    email: "gabriella.diasgmail.com"
  }

  @invalid_user2 %{
    name: "Nicolle Seraphim",
    password: "theotherpassword",
    email: "nicolle.seraphimgmail.com"
  }

  describe "create/1" do
    test "when all params are valid and there is a destination_id, complete a transaction" do
      {:ok, %User{id: origin_id}} = User.Create.create(@valid_user1)
      origin = Repo.get(User, origin_id)
      {:ok, %User{id: destination_id}} = User.Create.create(@valid_user2)
      destination = Repo.get(User, destination_id)

      transfer_params = %{
        "origin_id" => origin_id,
        "destination_id" => destination_id,
        "amount" => 1.0
      }
      Operation.Create.create(transfer_params)

      {:ok, %User{balance: origin_balance}} = DesafioElixirAPI.read_user(origin_id)
      {:ok, %User{balance: destination_balance}} = DesafioElixirAPI.read_user(destination_id)

      assert [^origin_balance, ^destination_balance] = [999.0, 1001.0]
    end

    test "when origin and destination are the same, return an error with the proper description" do
      {:ok, %User{id: user_id}} = User.Create.create(@valid_user1)
      user = Repo.get(User, user_id)

      transfer_params = %{
        "origin_id" => user_id,
        "destination_id" => user_id,
        "amount" => 1.0
      }
      result = Operation.Create.create(transfer_params)

      assert {:error, %Ecto.Changeset{errors: [destination_id: {"Destination and Origin must be different", []}]}} = result
    end
  end
end
