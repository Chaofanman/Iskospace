defmodule Iskospace.PageController do
  use Iskospace.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
