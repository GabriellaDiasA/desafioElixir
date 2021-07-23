defmodule DesafioElixirAPI.Operation.CreateInput do
  @moduledoc """
  Models the Operations table for interaction through the API.
  """

  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :origin_id, :string
    field :destination_id, :string
    field :amount, :float
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required([:origin_id, :amount])
    |> validate_number(:amount, greater_than: 0)
  end
end
