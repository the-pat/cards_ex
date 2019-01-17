defmodule Cards do

  def create_deck do
    values = 1..13
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # list comprehension
    for suit <- suits, value <- values do
      {value, suit}
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)

    File.write(filename, binary)
  end

  def load({:ok, binary}) do
    :erlang.binary_to_term(binary)
  end

  def load({:error, _}) do
    "That file does not exist"
  end

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

  def create_hand(hand_size) do
    Cards.create_deck() |>
      Cards.shuffle() |>
      Cards.deal(hand_size)
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

  def to_string(deck) when is_list(deck) do
    for card <- deck do
      Cards.to_string(card)
    end
  end

  def to_string({value, suit}) do
    "#{value} of #{suit}"
  end

end
