defmodule YoutubePlayer.User do
  use YoutubePlayer.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :description])
    |> validate_required([:name, :email, :description])
  end
end
