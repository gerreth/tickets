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
  id: 1,
  username: "Gerret",
  email: "plan-d@web.de",
  password_hash: "$argon2i$v=19$m=65536,t=6,p=1$CuQxGApOLfb/rJHI3Yp/Rw$kG3dB4aif2zccaG6C0/F+0moLVAn3fWJ3zg+qcAOkpo",
}
