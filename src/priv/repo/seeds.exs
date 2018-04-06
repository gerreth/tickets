# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Hello.Repo.insert!(%Hello.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Hello.Repo
alias Hello.Accounts.User

Repo.insert! %User{
  username: "Gerret",
  email: "plan-d@web.de",
  password: "Password",
}
