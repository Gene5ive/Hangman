defmodule Dictionary do

  @spec random_word :: any
  def random_word() do
    word_list()
    |> Enum.random()
  end

  @spec word_list :: [binary]
  def word_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end
end
