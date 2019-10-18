defmodule Hangman do

  alias Hangman.Game

  defdelegate new_game(), to: Game
  defdelegate make_move(), to: Game

end
