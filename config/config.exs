# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :youtube_player, YoutubePlayer.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "GsDIboQ6xSbnlv7wc3u50x1fllnwYrWNrJNLkL7GfSJ/j7wRrqfrsQMTGsNlEH9o",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: YoutubePlayer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

# Configure uberauth
config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, []}
  ]
#
config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
  redirect_uri: System.get_env("GOOGLE_REDIRECT_URI")

# config :youtube_player, YoutubePlayer.Database,
#   host: System.get_env("RETHINKDB_HOST"),
#   port: elem(Integer.parse(System.get_env("RETHINKDB_PORT")), 0)

config :youtube_player, ecto_repos: [YoutubePlayer.Repo]
