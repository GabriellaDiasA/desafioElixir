defmodule DesafioElixirAPI.Guardian.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :desafioElixirAPI,
    error_handler: DesafioElixirAPI.User.ErrorHandler,
    module: DesafioElixirAPI.Guardian

  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
end
