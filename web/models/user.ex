defmodule YoutubePlayer.User do
  use YoutubePlayer.Web, :model

  @allowed [:name, :email, :description, :token, :token_expires_at]
  @required [:name, :email, :token, :token_expires_at]

  schema "users" do
    field :name, :string
    field :email, :string
    field :description, :string
    field :token, :string
    field :token_expires_at, Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @allowed)
    |> validate_required(@required)
  end
end
