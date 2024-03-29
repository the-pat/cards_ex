defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Checks if the card exists within the deck

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, {1, "Spades"})
      true

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, {nil, "Fake Card!"})
      false

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Returns a list of tuples representing a deck of playing cards
  """
  def create_deck do
    values = 1..13
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # list comprehension
    for suit <- suits, value <- values do
      {value, suit}
    end
  end

  @doc """
    Create a deck, shuffle the deck, and return a hand and the remainder of the deck

  ## Examples

      iex> :rand.seed(:exsplus, {1, 2, 3})
      iex> {hand, deck} = Cards.create_hand(3)
      iex> hand
      [{5, "Clubs"}, {4, "Clubs"}, {10, "Hearts"}]
      iex> Enum.count(deck)
      49
  """
  def create_hand(hand_size) do
    Cards.create_deck() |>
      Cards.shuffle() |>
      Cards.deal(hand_size)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in hand.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      [{1, "Spades"}]
      iex> Enum.count(deck)
      51

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def load({:ok, binary}) do
    :erlang.binary_to_term(binary)
  end

  def load({:error, _}) do
    "That file does not exist"
  end

  @doc """
    Load a deck from the local file system
  """
  def load(filename) do
    filename |>
      File.read() |>
      Cards.load()

    ## same as above
    #case File.read(filename) do
    #  {:ok, binary} -> :erlang.binary_to_term binary
    #  {:error, _} -> "That file does not exist"
    #end
  end

  @doc """
    Store the deck on the local file system

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.save(deck, "deck-o-cards")
      :ok
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)

    File.write(filename, binary)
  end

  @doc """
    Returns a deck with the cards shuffled

    ## Examples

        iex> :rand.seed(:exsplus, {1, 2, 3})
        iex> deck = Cards.create_deck()
        iex> deck = Cards.shuffle(deck)
        iex> {hand, _} = Cards.deal(deck, 3)
        iex> hand
        [{5, "Clubs"}, {4, "Clubs"}, {10, "Hearts"}]

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def to_string({1, suit}) do
    Cards.to_string({"Ace", suit})
  end

  def to_string({11, suit}) do
    Cards.to_string({"Jack", suit})
  end

  def to_string({12, suit}) do
    Cards.to_string({"Queen", suit})
  end

  def to_string({13, suit}) do
    Cards.to_string({"King", suit})
  end

  @doc """
    Convert the card to a string

  ## Examples

      iex> Cards.to_string({1, "Spades"})
      "Ace of Spades"

      iex> Cards.to_string({11, "Hearts"})
      "Jack of Hearts"

      iex> Cards.to_string({12, "Clubs"})
      "Queen of Clubs"

      iex> Cards.to_string({13, "Diamonds"})
      "King of Diamonds"

      iex> Cards.to_string({3, "Hearts"})
      "3 of Hearts"

  """
  def to_string({value, suit}) do
    "#{value} of #{suit}"
  end

end
