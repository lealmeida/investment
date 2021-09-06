defmodule InvestimentWeb.PageController do
  use InvestimentWeb, :controller

  alias Investiment.Repo
  alias Investiment.Asset

  def index(conn, _params) do
    assets = Repo.all(Asset)
    render(conn, "index.html", assets: assets)
  end
end
