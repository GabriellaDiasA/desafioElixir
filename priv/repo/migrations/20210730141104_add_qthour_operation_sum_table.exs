defmodule DesafioElixirAPI.Repo.Migrations.AddQthourOperationSumTable do
  use Ecto.Migration

  def change do
    create table(:quarter_hour_sum) do
      add :amount, :float

      timestamps()
    end
  end
end
