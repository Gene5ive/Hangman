test "Enum.reduce practice test" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.new_game("wibble")

    for {guess, state} <- moves do
      game = Game.make_move(game, guess)
      assert game.game_state == state
    end

    Enum.reduce(moves, game, fn ({guess, state}, new_game) ->
      { new_game, _ } = Game.make_move(new_game, guess)
      assert new_game.game_state == state
      new_game
    end)

    reduce(enumerable, acc, fun)
    reduce(t(), any(), (element(), any() -> any())) :: any()

  end
