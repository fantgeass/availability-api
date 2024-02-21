defmodule AvailabilityApi.RestaurantTest do
  use ExUnit.Case

  alias AvailabilityApi.{Restaurant, Table, Reservation, TimePeriod}

  describe "available_tables/2" do
    setup do
      restaurant = %Restaurant{
        id: 1,
        name: "Restaurant 1",
        tables: [
          %Table{
            id: 1,
            name: "Table 1",
            reservations: [
              %Reservation{id: 1, start_datetime: ~N[2024-01-01 18:00:00]},
              %Reservation{id: 2, start_datetime: ~N[2024-01-01 19:00:00]},
              %Reservation{id: 3, start_datetime: ~N[2024-01-01 20:00:00]}
            ]
          },
          %Table{
            id: 2,
            name: "Table 2",
            reservations: [
              %Reservation{id: 4, start_datetime: ~N[2024-01-01 16:00:00]},
              %Reservation{id: 5, start_datetime: ~N[2024-01-01 17:00:00]},
              %Reservation{id: 6, start_datetime: ~N[2024-01-01 18:00:00]}
            ]
          },
          %Table{id: 3, name: "Table 3", reservations: []}
        ]
      }

      {:ok, restaurant: restaurant}
    end

    test "all tables are available", %{restaurant: restaurant} do
      tables =
        Restaurant.available_tables(restaurant, %TimePeriod{
          start: ~N[2024-01-01 10:00:00],
          finish: ~N[2024-01-01 15:00:00]
        })

      assert Enum.count(tables) == 3
    end

    test "some tables are not available", %{restaurant: restaurant} do
      tables =
        Restaurant.available_tables(restaurant, %TimePeriod{
          start: ~N[2024-01-01 16:00:00],
          finish: ~N[2024-01-01 20:00:00]
        })

      assert Enum.count(tables) == 1
    end
  end
end
