defmodule DesafioElixirAPI.User.Guardian do
  use Guardian, otp_app: :desafioElixirAPI

  alias DesafioElixirAPI.User

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  rescue
    Ecto.NoResultsError -> {:error, :user_not_found}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = DesafioElixirAPI.read_user(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
