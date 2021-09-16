defmodule Trimmr.Repo do
  use Ecto.Repo,
    otp_app: :trimmr,
    adapter: Ecto.Adapters.Postgres
end
