defmodule TrimmrWeb.URLController do
  use TrimmrWeb, :controller

  alias Trimmr.Links
  alias Trimmr.Links.URL

  action_fallback TrimmrWeb.FallbackController

  def index(conn, _params) do
    urls = Links.list_urls()
    render(conn, "index.json", urls: urls)
  end

  def create(conn, %{"url" => url_params}) do
    with {:ok, %URL{} = url} <- Links.create_url(url_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.url_path(conn, :show, url))
      |> render("show.json", url: url)
    end
  end

  def show(conn, %{"id" => id}) do
    url = Links.get_url(id)
    render(conn, "show.json", url: url)
  end

  def redirect_to_short(conn, %{"short" => short}) do
    url = Links.get_url_by_short(short)

    case url do
      nil ->
        conn
        |> put_status(404)
        |> render("404.json")

      _ ->
        IO.puts(url.short)

        conn
        |> redirect(external: url.full)
    end
  end
end
