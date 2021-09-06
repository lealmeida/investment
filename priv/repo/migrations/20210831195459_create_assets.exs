defmodule Investiment.Repo.Migrations.CreateAssets do
  use Ecto.Migration

  def change do
    create table(:assets) do
      add :code, :string
      add :investiment_value, :float
      add :total_amount, :integer
      add :dividend, :decimal
      add :type, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:assets, [:user_id])
  end
end
