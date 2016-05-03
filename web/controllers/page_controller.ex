defmodule YoutubePlayer.PageController do
  use YoutubePlayer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
