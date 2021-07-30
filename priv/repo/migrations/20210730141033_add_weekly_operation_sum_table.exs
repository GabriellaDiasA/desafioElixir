defmodule DesafioElixirAPI.Repo.Migrations.AddWeeklyOperationSumTable do
  use Ecto.Migration

  def change do
    create table(:weekly_sum) do
      add :amount, :float

      timestamps()
    end
  end
end
