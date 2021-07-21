defmodule DesafioElixirAPI do
  @moduledoc """
  Single entrypoint into the API.
  """

  alias DesafioElixirAPI.User.Create, as: UserCreate
  alias DesafioElixirAPI.User.Read, as: UserRead
  alias DesafioElixirAPI.User.Update, as: UserUpdate
  alias DesafioElixirAPI.User.Delete, as: UserDelete

  alias DesafioElixirAPI.Operation.Create, as: OperationCreate
  alias DesafioElixirAPI.Operation.Read, as: OperationRead
  alias DesafioElixirAPI.Operation.Update, as: OperationUpdate
  alias DesafioElixirAPI.Operation.Delete, as: OperationDelete

  defdelegate create_user(params), to: UserCreate, as: :create
  defdelegate read_all_user(), to: UserRead, as: :show_all
  defdelegate read_user(uuid), to: UserRead, as: :show_one
  defdelegate edit_user(user, params), to: UserUpdate, as: :update
  defdelegate delete_user(uuid), to: UserDelete, as: :delete

  defdelegate create_operation(params), to: OperationCreate, as: :create
  defdelegate read_all_operation(), to: OperationRead, as: :show_all
  defdelegate read_operation(uuid), to: OperationRead, as: :show_one
  defdelegate edit_operation(operation, params), to: OperationUpdate, as: :update
  defdelegate delete_operation(uuid), to: OperationDelete, as: :delete

end
