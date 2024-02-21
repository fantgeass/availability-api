defmodule AvailabilityApi.ReservationTest do
  use ExUnit.Case

  alias AvailabilityApi.{Reservation, TimePeriod}

  describe "is_overlapping/2" do
    setup do
      {:ok, reservation: %Reservation{id: 1, start_datetime: ~N[2024-01-01 18:00:00]}}
    end

    test "period after", %{reservation: reservation} do
      refute Reservation.is_overlapping(reservation, %TimePeriod{
               start: ~N[2024-01-01 19:00:00],
               finish: ~N[2024-01-01 20:00:00]
             })
    end

    test "period before", %{reservation: reservation} do
      refute Reservation.is_overlapping(reservation, %TimePeriod{
               start: ~N[2024-01-01 16:00:00],
               finish: ~N[2024-01-01 17:00:00]
             })
    end

    test "period start touching", %{reservation: reservation} do
      assert Reservation.is_overlapping(reservation, %TimePeriod{
               start: ~N[2024-01-01 18:00:00],
               finish: ~N[2024-01-01 19:00:00]
             })
    end

    test "period exact match", %{reservation: reservation} do
      assert Reservation.is_overlapping(reservation, %TimePeriod{
               start: ~N[2024-01-01 18:00:00],
               finish: ~N[2024-01-01 18:00:00]
             })
    end

    test "period finish touching", %{reservation: reservation} do
      assert Reservation.is_overlapping(reservation, %TimePeriod{
               start: ~N[2024-01-01 17:00:00],
               finish: ~N[2024-01-01 18:00:00]
             })
    end

    test "period enclosing", %{reservation: reservation} do
      assert Reservation.is_overlapping(reservation, %TimePeriod{
               start: ~N[2024-01-01 17:00:00],
               finish: ~N[2024-01-01 19:00:00]
             })
    end
  end
end
