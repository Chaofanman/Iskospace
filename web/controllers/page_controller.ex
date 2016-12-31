defmodule Iskospace.PageController do
  use Iskospace.Web, :controller

  alias Iskospace.Post

  def index(conn, _params) do
    posts = Repo.all(from p in Post, preload: [:user])
		render(conn, "index.html", posts: posts)
  end
end
