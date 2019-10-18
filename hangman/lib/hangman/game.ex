defmodule Hangman.Game do

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters:    [],
    used:       MapSet.new(),
  )

  @spec new_game(binary) :: Hangman.Game.t()
  def new_game(word) do
    %Hangman.Game{
      letters: word |> String.codepoints
    }
  end

  @spec new_game :: no_return
  def new_game() do
    new_game(Dictionary.random_word)
  end

  @spec make_move(%{game_state: :lost | :won}, any) :: {%{game_state: :lost | :won}, 123}
  def make_move(game = %{ game_state: state }, _guess) when state in [:won, :lost] do
    { game, tally(game) }
  end

  def make_move(game, guess) do
    game = accept_move(game, guess, MapSet.member?(game.used, guess))
    { game, tally(game) }
  end

  @spec accept_move(map, any, any) :: map
  def accept_move(game, guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  def accept_move(game, guess, _already_guessed) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  @spec score_guess(any, any) :: any
  def score_guess(game, _good_guess = true) do
    new_state = MapSet.new(game.letters)
    |> MapSet.subset?(game.used)
    |> maybe_won()
    Map.put(game, :game_state, new_state)
  end

  def score_guess(game, _not_good_guess) do
    game
  end

  def tally(game) do
    123
  end

  @spec maybe_won(any) :: :good_guess | :won
  def maybe_won(true), do: :won
  def maybe_won(_),    do: :good_guess

end
