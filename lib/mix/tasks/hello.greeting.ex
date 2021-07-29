defmodule Mix.Tasks.Hello.Greeting do
  use Mix.Task


  @shortdoc "Sends a greeting to us from Hello Phoenix"

  @moduledoc """
  This is where we would put any long form documentation or doctests.
  """

  alias DesafioElixirAPI.{Repo, User}

  def run(_args) do
    Mix.Task.run("app.start")
    Task.async_stream(0..5, fn _ -> say_hello() end, max_concurrency: 1) |> Enum.each(&IO.inspect/1)
    Mix.shell().info("Greetings from the Hello Phoenix Application!")
  end

  defp say_hello() do
    list = Repo.all(User)
    IO.inspect(list)
    Process.sleep(1000)
  end
end
