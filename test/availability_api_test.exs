defmodule AvailabilityApiTest do
  use ExUnit.Case

  alias AvailabilityApi.TimePeriod

  describe "get_available_tables/2" do
    test "restaurant exist" do
      assert {:ok, _} =
               AvailabilityApi.get_available_tables(1, %TimePeriod{
                 start: ~N[2024-01-01 10:00:00],
                 finish: ~N[2024-01-01 15:00:00]
               })
    end

    test "restaurant does not exist" do
      assert {:error, _} =
               AvailabilityApi.get_available_tables(2, %TimePeriod{
                 start: ~N[2024-01-01 10:00:00],
                 finish: ~N[2024-01-01 15:00:00]
               })
    end
  end
end
