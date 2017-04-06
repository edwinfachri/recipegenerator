require 'rubygems'
require 'nokogiri'
require 'open-uri'
class StaticPagesController < ApplicationController
  def home

  end
  def result
    @link = params[:generate]
    @x = Nokogiri::HTML(open(@link))
    @y = @x.css('li').text.split(" ")
    @arrAngka = ["1","2","3","4","5","6","7","8","9","10"]
    @arrQty = ["1/2","1/3","2/3", "1/4", "3/4"]
    @arrUnit = ["teaspoon", "spoon", "cup", "pinch", "pound", "cup",
                "tablespoon", "tbsp", "ounces", "quart"]
    @arrNoun = ["flour", "soda", "butter", "milk", "cabbage", "onion",
                "cilantro", "water", "oats", "apple", "carrot", "raisins", "cinnamon",
                "nutmeg", "ginger", "salt", "pecans", "yogurt", "oil", "pork",
                "buttermilk", "broth", "parsley", "pepper", "egg", "grits",
                "bacon", "sugar"]
    @arrAdj = ["all-purpose", "baking", "red", "finely", "chopped", "fresh", "garlic",
               "steel-cut", "shredded", "ground", "plain", "large", "vegetable",
               "yellow", "poultry", "cloves", "bone-in", "chicken", "chilli", "small",
               "white", "seasoning", "black", "jumbo"]
    @arrOther = ["of"]
    @kalimat = []
    @string = []
    @format = []
    @index = []
    @sebentar = []
    @y.each do |i, index|
      i = remove_trailing_comma(i)
      if @arrAngka.include?(i.singularize)
        @string.push(i)
        @format.push("angka")
        next
      elsif @arrUnit.include?(i.singularize)
        @string.push(i)
        @format.push("unit")
        next
      elsif @arrAdj.include?(i)
        @string.push(i)
        @format.push("adj")
        next
      elsif @arrNoun.include?(remove_trailing_comma(i).singularize)
        @string.push(i)
        @format.push("noun")
        next
      elsif @arrQty.include?(i)
        @sebentar = i.split("/")
        @string.push(@sebentar[0].to_f / @sebentar[1].to_f)
        @format.push("quantity")
      elsif @arrOther.include?(i)
        @string.push(i)
        @format.push("other")
      end
    end
    #Turn fraction into decimal
    @string.each_with_index do |z, index|
      if @format[index] == "angka" && @format[index+1] == "quantity"
        @string[index + 1] = @string[index].to_f + @string[index+1].to_f
        @string[index] = "x"
      end
    end

    @string.each_with_index do |z, index|
      if @format[index] == "quantity" && @format[index+1] == "unit" && @format[index+2] == "adj" && @format[index+3] == "adj"  && @format[index+4] == "adj" && @format[index+5] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2] + " " + @string[index+3] + " " + @string[index+4] + " " + @string[index+5])

      elsif @format[index] == "angka" && @format[index+1] == "unit" && @format[index+2] == "adj" && @format[index+3] == "adj"  && @format[index+4] == "adj" && @format[index+5] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2] + " " + @string[index+3] + " " + @string[index+4] + " " + @string[index+5])

      elsif @format[index] == "quantity" && @format[index+1] == "unit" && @format[index+2] == "adj" && @format[index+3] == "adj" && @format[index+4] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2] + " " + @string[index+3] + " " + @string[index+4])

      elsif @format[index] == "angka" && @format[index+1] == "unit" && @format[index+2] == "adj" && @format[index+3] == "adj" && @format[index+4] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2] + " " + @string[index+3] + " " + @string[index+4])

      elsif @format[index] == "quantity" && @format[index+1] == "unit" && @format[index+2] == "adj" && @format[index+3] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2] + " " + @string[index+3])

      elsif @format[index] == "angka" && @format[index+1] == "unit" && @format[index+2] == "adj" && @format[index+3] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2] + " " + @string[index+3])

      elsif @format[index] == "quantity" && @format[index+1] == "unit" && @format[index+2] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2])

      elsif @format[index] == "angka" && @format[index+1] == "unit" && @format[index+2] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2])

      elsif @format[index] == "quantity" && @format[index+1] == "adj" && @format[index+2] == "adj" && @format[index+3] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2] + " " + @string[index+3])

      elsif @format[index] == "angka" && @format[index+1] == "ajd" && @format[index+2] == "adj" && @format[index+3] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2] + " " + @string[index+3])

      elsif @format[index] == "quantity" && @format[index+1] == "adj" && @format[index+2] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2])

      elsif @format[index] == "angka" && @format[index+1] == "ajd" && @format[index+2] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2])

      elsif @format[index] == "unit" && @format[index+1] == "other" && @format[index+1] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2])

      elsif @format[index] == "quantity" && @format[index+1] == "unit" && @format[index+2] == "other" && @format[index+3] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2] + " " + @string[index+3])

      elsif @format[index] == "unit" && @format[index+1] == "other" && @format[index+2] == "unit" && @format[index+3] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1] + " " + @string[index+2] + " " + @string[index+3])

      elsif @format[index] == "angka" && @format[index+1] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1])

      elsif @format[index] == "quantity" && @format[index+1] == "noun"
        @kalimat.push(@string[index].to_s + " " + @string[index+1])
      end

    end

    @kalimat.each_with_index do |kalimat1, index1|
      @kalimat.each_with_index do |kalimat2, index2|
        if kalimat1 == kalimat2
        end
      end
    end

    @jsonnya = JSON.parse(File.read('app/assets/javascripts/stock.json'))

    @hasil = @string
    @index = @kalimat
    @hasilJson = @jsonnya["stock"]
    #@hasilJson = Dir.pwd
  end

  def remove_trailing_comma(str)
    str.nil? ? nil : str.chomp(",")
  end
end
