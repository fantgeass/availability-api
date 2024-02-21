defmodule AvailabilityApi.Restaurant do
  alias AvailabilityApi.{Table, TimePeriod}

  @type t :: %__MODULE__{
          id: integer(),
          name: String.t(),
          tables: [Table.t()]
        }

  defstruct [:id, :name, tables: []]

  @spec available_tables(t(), TimePeriod.t()) :: [Table.t()]
  def available_tables(restaurant, time_period) do
    Enum.filter(restaurant.tables, &Table.is_available(&1, time_period))
  end
end
