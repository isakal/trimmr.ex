defmodule TrimmrWeb.URLView do
  use TrimmrWeb, :view
  alias TrimmrWeb.URLView

  def render("index.json", %{urls: urls}) do
    %{data: render_many(urls, URLView, "url.json")}
  end

  def render("show.json", %{url: url}) do
    %{data: render_one(url, URLView, "url.json")}
  end

  def render("url.json", %{url: url}) do
    %{id: url.id,
      full: url.full,
      short: url.short,
      clicks: url.clicks}
  end
end
