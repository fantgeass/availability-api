defmodule AvailabilityApi.Table do
  alias AvailabilityApi.{Reservation, TimePeriod}

  @type t :: %__MODULE__{
          id: integer(),
          name: String.t(),
          reservations: [Reservation.t()]
        }

  defstruct [:id, :name, reservations: []]

  @spec is_available(Table.t(), TimePeriod.t()) :: boolean()
  def is_available(table, time_period) do
    Enum.find(table.reservations, &Reservation.is_overlapping(&1, time_period)) == nil
  end
end
