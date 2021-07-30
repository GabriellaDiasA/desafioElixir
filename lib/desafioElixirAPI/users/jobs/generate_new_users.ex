defmodule DesafioElixirAPI.User.Jobs.GenerateNewUsers do
  use Oban.Worker, queue: :default, max_attempts: 4

  import Ecto.Query

  alias DesafioElixirAPI.{Repo, User}

  @impl Oban.Worker
  def perform(_job) do
    randomize_params()
    |> User.changeset()
    |> Repo.insert()

    :ok
  end

  defp randomize_params do
    name = randomize_name()
    email = name <> "." <> randomize_last_name() <> "@" <> randomize_email_provider()
    password = randomize_password()

    %{
      "name" => name,
      "email" => email,
      "password" => password
    }
  end

  defp randomize_name do
    Enum.random([
      "Antonio", "Andre", "Anderson", "Bernardo", "Bruno", "Breno", "Caio", "Cesar", "Carlos", "Denis", "Daniel", "Douglas",
      "Eduardo", "Edmundo", "Elvis", "Felipe", "Fernando", "Fabio", "Gabriel", "Gustavo", "Gerson", "Humberto", "Helio", "Horacio",
      "Isabel", "Isadora", "Isis", "Juliana", "Julia", "Juliane", "Karen", "Kelyn", "Kara", "Lucia", "Luzia", "Luisa", "Marina", "Maria",
      "Marcela", "Natalia", "Neide", "Nanda", "Ophelia", "Olga", "Otilha", "Priscila", "Patricia", "Paula"
    ])
  end

  defp randomize_last_name do
    Enum.random([
      "Almeida", "Azevedo", "Braga", "Barros", "Brasil", "Bahiense", "Campos", "Cardoso", "Correia", "Castro", "Costa", "Fontes",
      "Guimarães", "Magalhães", "Macedo", "Matos", "Pedreira", "Queirós", "Ribeiro", "Rocha", "Siqueira", "Serra", "Souza", "Teixeira", "Valle"
    ])
  end

  defp randomize_email_provider do
    Enum.random([
      "gmail.com", "hotmail.com", "outlook.com", "yahoo.com"
    ])
  end

  defp randomize_password, do: Ecto.UUID.generate()
end
