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

  alias DesafioElixirAPI.DailySum.Read, as: DailySumRead
  alias DesafioElixirAPI.WeeklySum.Read, as: WeeklySumRead
  alias DesafioElixirAPI.MonthlySum.Read, as: MonthlySumRead
  alias DesafioElixirAPI.QtHourSum.Read, as: QtHourSumRead

  alias DesafioElixirAPI.Session.Create, as: SessionCreate
  alias DesafioElixirAPI.Session.Verify, as: SessionVerify

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

  defdelegate read_all_daily(), to: DailySumRead, as: :show_all
  defdelegate read_all_weekly(), to: WeeklySumRead, as: :show_all
  defdelegate read_all_monthly(), to: MonthlySumRead, as: :show_all
  defdelegate read_all_qt_hour(), to: QtHourSumRead, as: :show_all

  defdelegate create_session(user), to: SessionCreate, as: :generate_token_for_user
  defdelegate verify_token_ownership(user, token), to: SessionVerify, as: :verify

end
