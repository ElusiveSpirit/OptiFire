# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :optifire,
  ecto_repos: [Optifire.Repo]

# Configures the endpoint
config :optifire, OptifireWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KefkD9EbRQWVU/XJvPWnpNKooTBguwT2KtAHmKDFtOz/Kp0a1HVY0a2B2RNByEDt",
  render_errors: [view: OptifireWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Optifire.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
