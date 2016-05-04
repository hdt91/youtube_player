defmodule YoutubePlayer.AuthController do
  @moduledoc """
  Auth controller handles different routes for Ueberauth
  """

  use YoutubePlayer.Web, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    redirect conn, to: "/"
  end

  def delete(conn, _params) do
    redirect conn, to: "/"
  end
end
