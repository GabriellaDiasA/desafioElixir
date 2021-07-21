defmodule DesafioElixirAPI.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :desafioElixirAPI,
    adapter: Ecto.Adapters.Postgres
end
