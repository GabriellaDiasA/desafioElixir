defmodule DesafioElixirAPI.Repo.Migrations.AddMonthlyOperationSumTable do
  use Ecto.Migration

  def change do
    create table(:monthly_sum) do
      add :amount, :float

      timestamps()
    end
  end
end
