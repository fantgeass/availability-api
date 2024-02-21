defmodule AvailabilityApi.Reservation do
  alias AvailabilityApi.TimePeriod

  @type t :: %__MODULE__{
          id: integer(),
          start_datetime: NaiveDateTime.t()
        }

  defstruct [:id, :start_datetime]

  @spec is_overlapping(t(), TimePeriod.t()) :: boolean()
  def is_overlapping(reservation, time_period) do
    NaiveDateTime.diff(time_period.start, reservation.start_datetime) <= 0 and
      NaiveDateTime.diff(time_period.finish, reservation.start_datetime) >= 0
  end
end
