defmodule Phxdev.Repo do
  use Ecto.Repo,
    otp_app: :phxdev,
    adapter: Ecto.Adapters.Postgres
end
