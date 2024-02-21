defmodule AvailabilityApi.TimePeriodTest do
  use ExUnit.Case

  alias AvailabilityApi.TimePeriod

  describe "new/2" do
    test "start date before finish date" do
      assert {:ok, %TimePeriod{start: ~N[2024-01-01 10:00:00], finish: ~N[2024-01-01 11:00:00]}} =
               TimePeriod.new(~N[2024-01-01 10:00:00], ~N[2024-01-01 11:00:00])
    end

    test "start date after finish date" do
      assert {:error, _} = TimePeriod.new(~N[2024-01-01 10:00:00], ~N[2024-01-01 09:00:00])
    end
  end
end
