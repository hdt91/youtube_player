defmodule YoutubePlayer.Repo.Migrations.AddTokensInfoToUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :token, :string
      add :token_expires_at, :utc_datetime
    end
  end

  def down do
    alter table(:users) do
      remove :token
      remove :token_expires_at
    end
  end
end
