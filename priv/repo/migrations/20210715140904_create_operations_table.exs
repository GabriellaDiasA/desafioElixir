defmodule DesafioElixirAPI.Repo.Migrations.CreateOperationsTable do
  use Ecto.Migration

  def change do
    create table(:operations) do
      add :origin_id, references(:users, type: :binary_id)
      add :destination_id, references(:users, type: :binary_id)
      add :amount, :float
      add :status, :string

      timestamps()
    end
  end
end
