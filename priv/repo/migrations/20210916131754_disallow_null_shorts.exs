defmodule Trimmr.Repo.Migrations.DisallowNullShorts do
  use Ecto.Migration

  def change do
    alter table(:urls) do
    modify :short, :string, null: false
    end
  end
end
