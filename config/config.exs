# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :iskospace,
  ecto_repos: [Iskospace.Repo]

# Configures the endpoint
config :iskospace, Iskospace.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7JLY5MQ+RkcQwVK/rFW0TqwR5XGDn0x+p2J1KOn5KIT4KrdlpRy2xK2001MqVG/1",
  render_errors: [view: Iskospace.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Iskospace.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
