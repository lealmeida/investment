defmodule Investiment.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :integer
      add :date, :date
      add :price, :float
      add :taxes, :float
      add :total_value, :decimal
      add :type, :string
      add :operation, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :asset_id, references(:assets, on_delete: :nothing)

      timestamps()
    end

    create index(:transactions, [:user_id])
    create index(:transactions, [:asset_id])
  end
end
