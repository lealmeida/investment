defmodule Investiment.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :integer
    field :date, :date
    field :operation, :string
    field :price, :float
    field :taxes, :float
    field :total_value, :decimal
    field :type, :string
    belongs_to :user, Investiment.User
    belongs_to :asset, Investiment.Asset

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :date, :price, :taxes, :total_value, :type, :operation])
    |> validate_required([:amount, :date, :price, :taxes, :total_value, :type, :operation])
  end
end
