defmodule YoutubePlayer.AuthController do
  @moduledoc """
  Auth controller handles different routes for Ueberauth

  Reference: https://github.com/ueberauth/ueberauth_example
  """

  use YoutubePlayer.Web, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers
  alias YoutubePlayer.User

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Repo.get_by(User, name: auth.info.name) do
      %{email: email} ->
        user = basic_info(auth)
        conn
        |> put_flash(:info, "Successfully authenticated user #{email}")
        |> put_session(:current_user, user)
        |> redirect(to: "/")
      nil ->
        changeset = User.changeset(%User{}, %{
          "name" => auth.info.name,
          "email" => auth.info.email,
          "description" => auth.info.urls.profile,
        })
        case Repo.insert(changeset) do
          {:ok, _user} ->
            user = basic_info(auth)
            conn
            |> put_flash(:info, "Successfully authenticated")
            |> put_session(:current_user, user)
            |> redirect(to: "/")
          {:error, changeset} ->
            conn
            |> put_flash(:error, "Failed to authenticate")
            |> redirect(to: "/")
        end
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  defp basic_info(auth) do
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
