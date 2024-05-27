defmodule Phxdev.Utils do
  @spec random_string(integer()) :: bitstring()
  def random_string(length) do
    for _ <- 1..length, into: "", do: <<Enum.random('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')>>
  end
end
