defmodule InvestimentWeb.TransactionController do
  use InvestimentWeb, :controller

  import Ecto.Query

  alias Investiment.Repo
  alias Investiment.Transaction
  alias Investiment.Asset

  def new(conn, _params) do
    changeset = Transaction.changeset(%Transaction{}, %{})
    render conn, "new.html", changeset: changeset
  end

  @spec create(Plug.Conn.t(), any) :: Plug.Conn.t()
  def create(conn, %{"transaction" => %{"amount" => amount, "code_stock" => code_stock, "date" => date, "operation" => "BUY", "price" => price, "type" => type}}) do
    query = from a in Investiment.Asset, where: a.code == ^code_stock and a.user_id == ^conn.assigns.user.id
    investiment_value = String.to_float(price) * String.to_integer(amount)
    transaction_params = %{amount: amount, date: date, price: price, taxes: 1.10, total_value: String.to_integer(amount)*String.to_float(price)+ 1.10, type: type, operation: "BUY"}
    case Repo.one(query) do
      nil ->
        asset_params = %{code: code_stock,
         investiment_value: investiment_value,
         total_amount: amount,
         dividend: 0.0,
         type: type}
        change_set = conn.assigns.user
          |> Ecto.build_assoc(:assets)
          |> Asset.changeset(asset_params)
        case Repo.insert(change_set) do
          {:ok, asset} ->
            asset
            |> Ecto.build_assoc(:transactions, %{user_id: conn.assigns.user.id})
            |> Transaction.changeset(transaction_params)
            |> Repo.insert
        end
      asset ->
        IO.puts("'''''''''''''''''''''''''''''''''''")
        IO.inspect(asset.total_amount)
        IO.puts("'''''''''''''''''''''''''''''''''''")
        IO.inspect(String.to_integer(amount))
        IO.puts("'''''''''''''''''''''''''''''''''''")
        updte = Ecto.Changeset.change asset, %{total_amount: asset.total_amount + String.to_integer(amount),
        investiment_value: investiment_value + asset.investiment_value}
        Repo.update(updte)
        asset
        |> Ecto.build_assoc(:transactions, %{user_id: conn.assigns.user.id})
        |> Transaction.changeset(transaction_params)
        |> Repo.insert
    end
    render conn, "new.html", changeset: Transaction.changeset(%Transaction{}, %{})
  end

end
