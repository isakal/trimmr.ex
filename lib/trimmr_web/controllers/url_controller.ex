defmodule TrimmrWeb.URLController do
  use TrimmrWeb, :controller

  alias Trimmr.Repo
  alias Trimmr.Links
  alias Trimmr.Links.URL
  require Logger

  import Ecto.Changeset, only: [change: 2]

  action_fallback TrimmrWeb.FallbackController

  def index(conn, _params) do
    urls = Links.list_urls()
    render(conn, "index.json", urls: urls)
  end

  def create(conn, %{"data" => url_params}) do
    url_already_exists = Links.get_url_by_full(url_params["full"])

    case url_already_exists do
      %URL{} ->
        conn
        |> put_status(:created)
        |> render("show.json", url: url_already_exists)

      nil ->
        with {:ok, %URL{} = url} <- Links.create_url(url_params) do
          # Logger.debug("#{inspect(url)}")
          conn
          |> put_status(:created)
          |> render("show.json", url: url)
        end
    end
  end

  def show(conn, %{"id" => id}) do
    url = Links.get_url(id)
    render(conn, "show.json", url: url)
  end

  def redirect_to_short(conn, %{"short" => short}) do
    url = Links.get_url_by_short(short)

    case url do
      %URL{} ->
        Repo.transaction(fn ->
          Repo.update!(change(url, clicks: url.clicks + 1))
        end)

        conn
        |> redirect(external: url.full)

      nil ->
        conn
        |> put_status(404)
        |> render("404.json")
    end
  end
end
