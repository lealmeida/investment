defmodule Investiment.Repo.Migrations.CreateDividends do
  use Ecto.Migration

  def change do
    create table(:dividends) do
      add :date, :date
      add :type, :string
      add :description, :string
      add :value, :decimal
      add :user_id, references(:users, on_delete: :nothing)
      add :asset_id, references(:assets, on_delete: :nothing)

      timestamps()
    end

    create index(:dividends, [:user_id])
    create index(:dividends, [:asset_id])
  end
end
