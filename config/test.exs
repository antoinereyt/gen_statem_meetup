import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fsmlive, FsmliveWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "nsVtRlLjBKZh4VVKhu6vGlptZjICUT1idG5G/HeyDMt6S9d4wTntzsZxl9HmsmWW",
  server: false

# In test we don't send emails.
config :fsmlive, Fsmlive.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  # Enable helpful, but potentially expensive runtime checks
  enable_expensive_runtime_checks: true

config :fsmlive,
  light: [
    # duration in ms
    durations: [
      on_ttl: 200
    ],
    services: [
      bulb: Light.BulbMock
    ]
  ],
  payphone: [
    # one credit duration in ms
    credit_duration: 100,
    warning_threshold: 300,
    services: [
      hardware: Payphone.Hardware.Test
    ]
  ],
  traffic_light: [
    services: [
      hardware: TrafficLight.HardwareMock
    ],
    # durations in ms
    durations: [
      orange: 200,
      people_pass: 300,
      all_stop: 200
    ]
  ]
