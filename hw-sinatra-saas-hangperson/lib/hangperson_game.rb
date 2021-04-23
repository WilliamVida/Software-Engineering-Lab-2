class HangpersonGame
  
    # add the necessary class methods, attributes, etc. here
    # to make the tests in spec/hangperson_game_spec.rb pass.

    # Get a word from remote "random word" service

    # def initialize()
    # end

    attr_accessor :word, :guesses, :wrong_guesses

    def initialize(word)
        @word = word
        @guesses = ""
        @wrong_guesses = ""
    end
  
    def guess(letter)
        if letter.nil? or letter.empty? or letter !~ /[[:alpha:]]/
           raise ArgumentError 
        end

        if @word.include? letter.downcase
            if @guesses.include? letter.downcase
                 return false
            else
                @guesses += letter
            end
        else
            if @wrong_guesses.include? letter.downcase
                return false
            else
                @wrong_guesses +=letter
            end
        end
    end
    
    def word_with_guesses
        display_guesses = ""

        @word.each_char do |letter|
           if @guesses.include? letter
               display_guesses += letter
           else
               display_guesses += "-"
           end
        end
        
        return display_guesses
    end
    
    def check_win_or_lose
       if !word_with_guesses.include? "-"
           return :win
       elsif @wrong_guesses.length == 7
           return :lose
       else
           return :play
       end        
    end

    # You can test it by running $ bundle exec irb -I. -r app.rb
    # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
    #  => "cooking"   <-- some random word
    def self.get_random_word
        require 'uri'
        require 'net/http'
        uri = URI('http://randomword.saasbook.info/RandomWord')
        Net::HTTP.new('randomword.saasbook.info').start { |http|
            return http.post(uri, "").body
        }
    end

end
