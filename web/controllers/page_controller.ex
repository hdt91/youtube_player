defmodule YoutubePlayer.PageController do
  @moduledoc """
  Page controller contains:
  - Index page shows welcome screen if user is logged in, otherwise
  shows the auth page that will trigger Ueberauth
  """
  use YoutubePlayer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", current_user: get_session(conn, :current_user)
  end
end
