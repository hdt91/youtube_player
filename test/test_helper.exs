ExUnit.start

Mix.Task.run "ecto.create", ~w(-r YoutubePlayer.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r YoutubePlayer.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(YoutubePlayer.Repo)

