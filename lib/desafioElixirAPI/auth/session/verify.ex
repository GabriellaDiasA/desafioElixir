defmodule DesafioElixirAPI.Session.Verify do
  alias DesafioElixirAPI.Guardian

  def verify(user, token) do
    with {:ok, claims} <- Guardian.decode_and_verify(token),
         {:ok, token_user} <- Guardian.resource_from_claims(claims),
         :ok <- compare_users(user, token_user) do
      {:ok, user}
    else
      _ -> {:error, "Invalid token"}
    end
  end

  defp compare_users(user, token_user) do
    if user.id == token_user.id do
      :ok
    else
      :error
    end
  end
end
