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

  @derive {Jason.Encoder, only: [:id, :inserted_at] ++ @required_fields ++ @optional_fields}

  schema "operations" do
    field :amount, :float
    belongs_to :origin, User, [foreign_key: :origin_id]
    belongs_to :destination, User, [foreign_key: :destination_id]

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:amount, greater_than: 0)
    |> validate_difference(:destination_id)
  end

  defp validate_difference(changeset, field) when is_atom(field) do
    origin_id = changeset.changes[:origin_id]
    validate_change(changeset, field, fn changeset, field ->
      if field != origin_id do
        []
      else
        [destination_id: "Destination and Origin must be different"]
      end
    end)
  end
end
