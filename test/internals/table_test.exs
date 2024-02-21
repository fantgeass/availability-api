defmodule AvailabilityApi.TableTest do
  use ExUnit.Case

  alias AvailabilityApi.{Table, Reservation, TimePeriod}

  describe "is_available/2" do
    setup do
      table = %Table{
        name: "Table 1",
        reservations: [
          %Reservation{id: 1, start_datetime: ~N[2024-01-01 18:00:00]},
          %Reservation{id: 2, start_datetime: ~N[2024-01-01 19:00:00]}
        ]
      }

      {:ok, table: table}
    end

    test "available if no overlapping reservations exist", %{table: table} do
      assert Table.is_available(table, %TimePeriod{
               start: ~N[2024-01-01 14:00:00],
               finish: ~N[2024-01-01 15:00:00]
             })
    end

    test "not available if overlapping reservations exist", %{table: table} do
      refute Table.is_available(table, %TimePeriod{
               start: ~N[2024-01-01 17:00:00],
               finish: ~N[2024-01-01 20:00:00]
             })
    end
  end
end
