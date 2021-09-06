defmodule InvestimentWeb.DividendController do
  use InvestimentWeb, :controller

  alias Investiment.Repo
  alias Investiment.Dividend
  alias Investiment.Asset
  alias Decimal, as: D

  def new(conn, %{"id" => asset_id}) do
    asset = Repo.get(Asset, asset_id)
    changeset = Dividend.changeset(%Dividend{}, %{})
    render conn, "new.html", changeset: changeset, asset: asset
  end

  @spec create(Plug.Conn.t(), any) :: Plug.Conn.t()
  def create(conn, %{"dividend" => dividend, "id" => asset_id}) do

    asset = Repo.get(Asset, asset_id)
    asset
    |> Ecto.build_assoc(:dividends, %{user_id: conn.assigns.user.id})
    |> Dividend.changeset(dividend)
    |> Repo.insert

    %{"value" => value} = dividend
    asset
    |> Ecto.Changeset.change(dividend: D.add(D.new(value),asset.dividend) )
    |> Repo.update

    render conn, "new.html", changeset: Dividend.changeset(%Dividend{}, %{}), asset: asset
  end

end
