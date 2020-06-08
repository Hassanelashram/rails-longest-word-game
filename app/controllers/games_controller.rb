class GamesController < ApplicationController
  require 'open-uri'
  require 'json'
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    @letters = @letters.split
    @valid_word = included?(@word, @letters)
    @english_word = english?(@word)
    @valid_both = @valid_word && @english_word
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english?(word)
    url = 'https://wagon-dictionary.herokuapp.com/' + word
    content = open(url).read
    obj = JSON.parse(content)
    if obj['found'] == true
      true
    else
      false
    end
  end
end
