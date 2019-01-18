defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 52 cards" do
    deck = Cards.create_deck
    length = Enum.count(deck)
    assert length == 52
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end
end
