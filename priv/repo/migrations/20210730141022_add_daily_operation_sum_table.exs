defmodule DesafioElixirAPI.Repo.Migrations.AddDailyOperationSumTable do
  use Ecto.Migration

  def change do
    create table(:daily_sum) do
      add :amount, :float

      timestamps()
    end
  end
end
