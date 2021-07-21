# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :desafioElixirAPI,
  ecto_repos: [DesafioElixirAPI.Repo]

config :desafioElixirAPI, DesafioElixirAPI.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :desafioElixirAPI, DesafioElixirAPIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mGTOJuKFIxH5Swv2u7PIkEcA35noeiAMA4wOvgsVFB/tHjBUbcN5iL5/yOLQFxMJ",
  render_errors: [view: DesafioElixirAPIWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: DesafioElixirAPI.PubSub,
  live_view: [signing_salt: "8IgF9cGP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
