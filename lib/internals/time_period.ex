defmodule AvailabilityApi.TimePeriod do
  defstruct [:start, :finish]

  @type t :: %__MODULE__{
          start: NaiveDateTime.t(),
          finish: NaiveDateTime.t()
        }

  @spec new(NaiveDateTime.t(), NaiveDateTime.t()) :: {:ok, t()} | {:error, String.t()}
  def new(start, finish) do
    if NaiveDateTime.diff(finish, start) >= 0 do
      {:ok,
       %__MODULE__{
         start: start,
         finish: finish
       }}
    else
      {:error, "Start datetime begins AFTER finish datetime"}
    end
  end
end
