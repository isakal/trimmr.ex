defmodule Trimmr.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :full, :string
      add :short, :string
      add :clicks, :integer

      timestamps()
    end

    create unique_index(:urls, [:short])
  end
end
