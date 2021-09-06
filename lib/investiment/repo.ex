defmodule Investiment.Repo do
  use Ecto.Repo,
    otp_app: :investiment,
    adapter: Ecto.Adapters.Postgres
end
