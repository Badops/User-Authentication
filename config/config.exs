# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :user_authentication,
  ecto_repos: [UserAuthentication.Repo]

# Configures the endpoint
config :user_authentication, UserAuthenticationWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sel3AMYa4zzgucOsV4/nR0irw2OcVkBZ36u4Xn1Wl8DWkR9/bg5x5TF5IuwM55NR",
  render_errors: [view: UserAuthenticationWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: UserAuthentication.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
