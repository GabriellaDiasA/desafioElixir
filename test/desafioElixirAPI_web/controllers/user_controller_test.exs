defmodule DesafioElixirAPIWeb.UserControllerTest do
  @moduledoc """
  Unit tests for the User Controller module.
  """

  use DesafioElixirAPIWeb.ConnCase

  describe "create/2" do

    test "when all params are valid, create a user", %{conn: conn} do
      params = %{
        name: "Nicolle Seraphim5",
        password: "1234567",
        email: "nicolle.seraphim5@gmail.com.br"
      }

      response = conn
        |> post(Routes.user_path(conn, :create, params))
        |> json_response(:ok)

      assert %{
        "message" => "user created.",
        "user" => _user
      } = response

    end

    test "when params are invalid, return an error", %{conn: conn} do
      params = %{
        name: "Nicolle Seraphim5",
        email: "nicolle.seraphim5@gmail.com.br"
      }

      response = conn
        |> post(Routes.user_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
        "message" => %{
          "password" => ["can't be blank"]
        }
      } = response

    end
  end

end
