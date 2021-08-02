defmodule DesafioElixirAPI.Session.Create do
  @moduledoc """
  Creates sessions based on user info
  """

  alias DesafioElixirAPI.Guardian

  def generate_token_for_user(user) do
    {:ok, token, _claims} = Guardian.encode_and_sign(user)
  end
end
