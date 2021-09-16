defmodule Trimmr.LinksTest do
  use Trimmr.DataCase

  alias Trimmr.Links

  describe "urls" do
    alias Trimmr.Links.URL

    @valid_attrs %{clicks: 42, full: "some full", short: "some short"}
    @update_attrs %{clicks: 43, full: "some updated full", short: "some updated short"}
    @invalid_attrs %{clicks: nil, full: nil, short: nil}

    def url_fixture(attrs \\ %{}) do
      {:ok, url} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Links.create_url()

      url
    end

    test "list_urls/0 returns all urls" do
      url = url_fixture()
      assert Links.list_urls() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert Links.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      assert {:ok, %URL{} = url} = Links.create_url(@valid_attrs)
      assert url.clicks == 42
      assert url.full == "some full"
      assert url.short == "some short"
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      assert {:ok, %URL{} = url} = Links.update_url(url, @update_attrs)
      assert url.clicks == 43
      assert url.full == "some updated full"
      assert url.short == "some updated short"
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = url_fixture()
      assert {:error, %Ecto.Changeset{}} = Links.update_url(url, @invalid_attrs)
      assert url == Links.get_url!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %URL{}} = Links.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> Links.get_url!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = Links.change_url(url)
    end
  end
end
