require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @grid = []
    10.times { @grid << alphabet.sample }
  end

  def score
    word = params[:word].upcase
    word_array = word.chars
    array = params[:grid].split(/ /, 10)
    array_join = array.join(', ')

    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    string_file = URI.open(url).read
    result = JSON.parse(string_file)

    if word_array.all? { |e| array.include?(e) }
      if result['found'] == true
        @message = "Congratulations! #{word} is a valid word!"
      elsif result['found'] == false
        @message = "Sorry but #{word} does not seem to be a valid English word..."
      end
    else
      @message = "Sorry but #{word} can't be built out of #{array_join}"
    end
  end
end
