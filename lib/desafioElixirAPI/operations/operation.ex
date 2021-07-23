defmodule DesafioElixirAPI.Operation do
  @moduledoc """
  Models the Operations table for interaction through the API.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias DesafioElixirAPI.User

  @primary_key {:id, :binary_id, autogenerate: true}

  @foreign_key_type :binary_id

  @required_fields [:origin_id, :amount]

  @optional_fields [:destination_id]

  @derive {Jason.Encoder, only: [:id] ++ @required_fields ++ @optional_fields}

  schema "operations" do
    field :amount, :float
    belongs_to :origin, User, foreign_key: :origin_id
    belongs_to :destination, User, foreign_key: :destination_id

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:amount, greater_than: 0)
  end
end
