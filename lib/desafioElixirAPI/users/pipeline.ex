defmodule DesafioElixirAPI.User.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :desafioElixirAPI,
    error_handler: DesafioElixirAPI.User.ErrorHandler,
    module: DesafioElixirAPI.User.Guardian

  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
end
