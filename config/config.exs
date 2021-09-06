# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :investiment,
  ecto_repos: [Investiment.Repo]

# Configures the endpoint
config :investiment, InvestimentWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "H/l3sSyr5mJVQQ3W79UyXeKLawzjVSwBqiPdWseWA34B0lxwrnpV9JbYRhInTG1G",
  render_errors: [view: InvestimentWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Investiment.PubSub,
  live_view: [signing_salt: "YL0GbajH"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
