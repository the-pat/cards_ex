defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  describe "contains?/2" do

    test "deck contains the ace of spades" do
      deck = Cards.create_deck()
      aceOfSpades = {1, "Spades"}

      assert Cards.contains?(deck, aceOfSpades)
    end

    test "deck does not contain a Joker" do
      deck = Cards.create_deck()
      joker = {nil, "Joker"}

      refute Cards.contains?(deck, joker)
    end
  end

  describe "create_deck/0" do

    test "deck length is 52" do
      deck = Cards.create_deck()

      assert Enum.count(deck) == 52
    end

  end

  describe "create_hand/1" do

    test "with `hand_size` of 1, returns a hand with 5 of Clubs" do
      :rand.seed(:exsplus, {1, 2, 3})
      {hand, _} = Cards.create_hand(1)

      assert hand == [{5, "Clubs"}]
    end

    test "with `hand_size` of 2, returns a deck with 50 cards" do
      {_, deck} = Cards.create_hand(2)

      assert Enum.count(deck) == 50
    end

  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end
end
