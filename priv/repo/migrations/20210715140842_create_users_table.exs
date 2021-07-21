defmodule DesafioElixirAPI.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :password_hash, :string
      add :balance, :float

      timestamps()
    end

    create unique_index(:users, [:email])
    create constraint(:users, :balance_must_be_greater_than_or_equal_to_zero, check: "balance >= 0")
  end

end
