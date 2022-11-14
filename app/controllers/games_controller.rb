require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(9)
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    @result = include(@word, @letters)
    @english_word = english_word(@word)
  end

  private

  def include(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_seri = URI.open(url).read
    user = JSON.parse(user_seri)
    user['found']
  end
end
