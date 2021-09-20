defmodule Trimmr.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias Trimmr.Repo

  alias Trimmr.Links.URL

  @doc """
  Returns the list of urls.

  ## Examples

      iex> list_urls()
      [%URL{}, ...]

  """
  def list_urls do
    Repo.all(URL)
  end

  @doc """
  Gets a single url.

  Raises `Ecto.NoResultsError` if the Url does not exist.

  ## Examples

      iex> get_url!(123)
      %URL{}

      iex> get_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_url(id), do: Repo.get(URL, id)

  @doc """
  Creates a url.

  ## Examples

      iex> create_url(%{field: value})
      {:ok, %URL{}}

      iex> create_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_url(attrs \\ %{}) do
    %URL{}
    |> URL.changeset(attrs)
    |> Repo.insert()
  end

  def get_url_by_full(full) do
    Repo.one(
      from u in URL,
        where: u.full == ^full,
        select: u
    )
  end

  def get_url_by_short(short) do
    Repo.one(
      from u in URL,
        where: u.short == ^short,
        select: u
    )
  end
end
