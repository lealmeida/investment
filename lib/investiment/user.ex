defmodule Investiment.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    has_many :transactions, Investiment.Transaction
    has_many :assets, Investiment.Asset
    has_many :dividends, Investiment.Dividend

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
  end
end

# mix phx.gen.schema Asset assets code:string total_amount:integer average_price:float investiment_value:float dividends:float dy:decimal average_price_after_dividends:float investiment_value_after_dividends:float type:string user_id:references:users
# mix phx.gen.schema Transaction transactions amount:integer date:date price:float taxes:float total_value:decimal type:string user_id:references:users asset_id:references:assets
# mix phx.gen.schema Dividend dividends date:date type:string description:string value:float user_id:references:users asset_id:references:assets
