# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Trimmr.Repo.insert!(%Trimmr.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Trimmr.Repo
alias Trimmr.Links.URL

Faker.start()

for i <- 1..5 do
  %URL{}
  |> URL.changeset(%{
    full: Faker.Internet.url()
  })
  |> Repo.insert!()
end
