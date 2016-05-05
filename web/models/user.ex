defmodule YoutubePlayer.User do
  @moduledoc """
  Model for user. Get information through auth
  """

  alias Ueberauth.Auth
  import RethinkDB.Query, only: [table: 1, filter: 2, insert: 2]

  def find_or_create(%Auth{} = auth) do
    user = table("users")
      |> filter(%{username: auth.info.nickname})
      |> YoutubePlayer.Database.run
      |> IO.inspect

      cond do
        length(user.data) == 0 -> create_user(auth)
        true -> nil
      end

    {:ok, basic_info(auth)}
  end

  def create_user(auth) do
    table("users")
      |> insert(%{username: auth.info.nickname})
      |> YoutubePlayer.Database.run
  end

  def basic_info(auth) do
    %{id: auth.uid, name: name_from_auth(auth), avatar: auth.info.image}
  end

  defp name_from_auth(auth) do
    if auth.info.name do
      auth.info.name
    else
      name = [auth.info.first_name, auth.info.last_name]
      |> Enum.filter(&(&1 != nil and &1 != ""))

      cond do
        length(name) == 0 -> auth.info.nickname
        true -> Enum.join(name, " ")
      end
    end
  end
end
