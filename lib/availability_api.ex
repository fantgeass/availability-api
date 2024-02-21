defmodule AvailabilityApi do
  alias AvailabilityApi.{Restaurant, Table, Reservation, TimePeriod}

  @spec get_restaurant(integer()) :: Restaurant.t() | nil
  defp get_restaurant(restaurant_id) do
    restaurant_map = %{
      1 => %Restaurant{
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
    }

    restaurant_map[restaurant_id]
  end

  @spec get_available_tables(integer, TimePeriod.t()) ::
          {:ok, [Table.t()]} | {:error, String.t()}
  def get_available_tables(restaurant_id, time_period) do
    case get_restaurant(restaurant_id) do
      %Restaurant{} = restaurant -> {:ok, Restaurant.available_tables(restaurant, time_period)}
      _ -> {:error, "Restaurant does not exist"}
    end
  end
end
