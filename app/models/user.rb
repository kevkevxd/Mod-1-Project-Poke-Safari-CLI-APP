class User < ActiveRecord::Base
    has_many :pokemons
    def self.sign_up
        puts "Please enter a username:"
        username = gets.chomp.strip 
        puts "Please enter a password:"
        password = gets.chomp.strip
        puts "Please enter any gender:"
        gender = gets.chomp.strip
        puts "Please enter your trainer name:"
        trainer_name = gets.chomp.strip
        user = User.create(username: username, password: password, gender: gender, trainer_name: trainer_name)
        user.save
    end
    
    def self.sign_in
        puts "Please enter your username:"
        username = gets.chomp.strip
        puts "Please enter your password:"
        password = gets.chomp.strip
        User.all.find_by(username: username, password: password)
    end

    def welcome
        puts "To catch a pokemon type '1' To look at your PC (Pokemon Collection) type '2'"
        user_decision = gets.chomp.strip
        if user_decision == "1"

            self.catch_pokemon

        elsif user_decision == "2"

            self.pc_loadup
    
        else

            puts "Please enter either 1 or 2. Try again:"
            self.welcome 
        end
    end

    def pc_loadup
         pokemon = self.pokemons.reload  
         pokemon.each do |pokemon|
            puts "|--------------------------------------------------------------------------|"
            puts " NICKNAME: #{pokemon.nickname}"
            puts "|--------------------------------------------------------------------------|"
            puts " SPECIES: #{pokemon.species.name.upcase}"
            puts "|--------------------------------------------------------------------------|"
            if pokemon.species.type.type_two == nil
                puts " TYPE(S): #{pokemon.species.type.type_one.upcase}" 
            else   
                puts " TYPE(S): #{pokemon.species.type.type_one.upcase} #{pokemon.species.type.type_two.upcase}"
            end
            puts "|--------------------------------------------------------------------------|"
            puts " OWNER: #{self.trainer_name.upcase}"
            puts "////////////////////////////////////////////////////////////////////////////"
         end
        
        if self.pokemons.count > 0
            self.poke_ball 
            self.pc_select 
        else 
            puts "Looks like you don't have any pokemon yet. Go catch some!"
            self.welcome 
        end
        
    end

    def catch_pokemon
        #puts "Please enter the Pokemon you want to catch:"
        #pokemon_name = gets.chomp.downcase
        random_pokemon = rand(0..151)
        species = Species.all[random_pokemon]
        ball_count = 10 
        random_number = rand(1..10)
        random_user_number = rand(1..10)
        until ball_count == 0 do
            puts "You encounter a wild #{species.name.upcase}. You have #{ball_count} safari balls left."
            puts "-------------------------------------"
            puts "|                                   |"
            puts "|  THROW BALL 't'   THROW BAIT 'b'  |"
            puts "|                                   |"
            puts "|  THROW ROCK 'r'   RUN AWAY 'e'    |"
            puts "|                                   |"
            puts "-------------------------------------"
            catch_or_run = gets.chomp.strip

            if catch_or_run == 'e'
                puts "Got away safely!"
                self.welcome

            elsif catch_or_run == 't'  
                ball_count -= 1
                if random_number == random_user_number
                    puts "Congratulations! You caught a #{species.name.upcase} " #wanted to create a new method but needed to grab species name
                    puts "Please enter a nickname for your pokemon:"
                    nickname = gets.chomp.strip
                    Pokemon.create(nickname: nickname, user_id: self.id, species_id: species.id)
                    self.welcome
                end
                puts "Oh, no! The #{species.name.upcase} broke free!"
            elsif catch_or_run == 'r'
                rock_number = rand(1..3)
                user_rock_number = rand (1..3)
                random_number = (1..5)
                random_user_number = (1..5)
                puts "                                                   "
                puts "You threw a rock at #{species.name.upcase}"
                if rock_number == user_rock_number
                    puts "Wild #{species.name.upcase} has fled!"
                    self.welcome 
                end
                puts "                                                   "
                puts "#{species.name.upcase} is watching you carefully..."
                puts "                                                   "
            else 
                puts "That's not a valid action! The wild #{species.name.upcase} has fled! Try again."
                self.catch_pokemon
            end

        end
        puts "Wild #{species.name.upcase} has fled!"
        self.welcome 
    end



    def poke_ball 
        puts "                    "
        puts "    ############   "
        puts "  ################ "
        puts " ################## "
        puts "########[ 0 ]#######"
        puts " ################## "
        puts "  ################ "
        puts "    ############   "
        puts "                  "
    end

    def poke_ball_two
        puts "    ##########   "
        puts "   #############  "
        puts "  ############### "
        puts " #####[ 0 ]#######"
        puts "##################"
        puts "  ############### "
        puts "   ############"
    end

    def pc_select
        puts 'Would you like to release a pokemon or go back to the menu? Enter release or menu:'
            user_response = gets.chomp.downcase.strip 
            if user_response == 'release'
                puts "Which pokemon would you like to release? Enter their nickname (remember nicknames are case sensitive):"
                user_nickname = gets.chomp.strip
                if self.pokemons.find_by(nickname: user_nickname)
                    self.pokemons.find_by(nickname: user_nickname).destroy
                    self.welcome
                else
                    puts "Please enter a valid nickname. Try again:"
                    self.pc_loadup
                end
            elsif user_response == 'menu'
                self.welcome 
            else
                puts "Not a valid input try again."
                self.pc_loadup   
            end 
    end

    


end

