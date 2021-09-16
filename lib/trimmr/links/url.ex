defmodule Trimmr.Links.URL do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :full, :string
    field :short, :string, default: Nanoid.generate()
    field :clicks, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:full, :short, :clicks])
    # |> put_change(:short, Nanoid.generate())
    |> validate_required([:full, :short, :clicks])
    |> unique_constraint(:full)
  end
end
