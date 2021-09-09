defmodule Investiment.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assets" do
    field :code, :string
    field :investiment_value, :decimal
    field :amount, :integer
    field :dividend, :decimal
    field :type, :string
    belongs_to :user, Investiment.User
    has_many :transactions, Investiment.Transaction
    has_many :dividends, Investiment.Dividend

    timestamps()
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:code, :investiment_value, :amount, :dividend, :type])
    |> validate_required([:code, :investiment_value, :amount, :type])
  end
end
