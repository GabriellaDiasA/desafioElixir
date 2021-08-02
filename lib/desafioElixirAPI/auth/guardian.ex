defmodule DesafioElixirAPI.Guardian do
  alias DesafioElixirAPI.{User, Repo}

  use Guardian, otp_app: :desafioElixirAPI

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  rescue
    Ecto.NoResultsError -> {:error, :user_not_found}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Repo.get(User, id) do
      user ->
        {:ok, user}

      nil ->
        {:error, "User not found"}
    end
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
