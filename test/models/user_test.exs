defmodule YoutubePlayer.UserTest do
  use YoutubePlayer.ModelCase

  alias YoutubePlayer.User

  @valid_attrs %{description: "some content", email: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
