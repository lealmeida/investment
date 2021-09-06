defmodule Investiment.Dividend do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dividends" do
    field :date, :date
    field :description, :string
    field :type, :string
    field :value, :float
    belongs_to :asset, Investiment.Asset
    belongs_to :user, Investiment.User


    timestamps()
  end

  @doc false
  def changeset(dividend, attrs) do
    dividend
    |> cast(attrs, [:date, :type, :description, :value])
    |> validate_required([:date, :type, :description, :value])
  end
end
