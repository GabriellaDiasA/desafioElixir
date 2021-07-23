defmodule DesafioElixirAPI.User do
  @moduledoc """
  Models the Users table for interaction through the API.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset
  alias DesafioElixirAPI.Operation

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields [:email, :name, :password]

  @derive {Jason.Encoder, only: [:id, :email, :name, :password_hash, :balance]}

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :balance, :float, default: 1000.0
    has_many :origin, Operation, foreign_key: :origin_id
    has_many :destination, Operation, foreign_key: :destination_id

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_fields ++ [:balance])
    |> validate_required(@required_fields)
    |> validate_number(:balance, greater_than_or_equal_to: 0)
    |> validate_length(:password, min: 6)
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> add_password_hash()
  end

  def transaction_changeset(struct \\ %__MODULE__{}, params) do

  end

  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp add_password_hash(changeset) do
    changeset
  end
end
