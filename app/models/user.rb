class User < ActiveRecord::Base
    has_many :pokemons
    def self.sign_up
        prompt = TTY::Prompt.new
        username = prompt.ask("Please enter a username:") 
        
        password = prompt.mask("Please enter a password:")
         
        gender = prompt.select("What is your gender?", %w(male female non-binary))
        
        trainer_name = prompt.ask("Please enter your trainer name:")
        user = User.create(username: username, password: password, gender: gender, trainer_name: trainer_name)
        user.save
        User.all.find_by(username: username, password: password)
        user.welcome 
    end
    
    def self.sign_in
        prompt = TTY::Prompt.new
        username = prompt.ask("Please enter a username:")
        
        password = prompt.mask("Please enter a password:")
        
        User.all.find_by(username: username, password: password)
    end

    

     def welcome
         prompt = TTY::Prompt.new
         user_decision = prompt.select("What would you like to do?", %w(CATCH_POKEMON PC QUIT))
        
        
         if user_decision == "CATCH_POKEMON"

            self.catch_pokemon

         elsif user_decision == "PC"

             self.pc_loadup

         elsif user_decision == "QUIT"
            puts "Press CRTL C to exit the terminal."
            puts "                     "
            Cli.start
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
            puts "                                   "
            puts "POKÉMON COUNT: #{pokemons.count}"
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
        mood = rand(1..2)
        ball_count = 10 
        random_number = rand(1..6)
        random_user_number = rand(1..6)
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
                
                else
                puts "Oh, no! The #{species.name.upcase} broke free!"
                end

            elsif catch_or_run == 'r'
                puts "                                                   "
                puts "You threw a rock at #{species.name.upcase}"
                rock_number = rand(1..3)
                user_rock_number = rand (1..3)
                if mood == 1
                    random_number = (1..4)
                    random_user_number = (1..4)
                    puts "                                                   "
                    puts "The #{species.name.upcase} liked that."
                else
                    puts "                                                   " 
                    puts "The #{species.name.upcase} really did not like that."
                end

                if rock_number == user_rock_number
                    puts "Wild #{species.name.upcase} has fled!"
                    self.welcome 
                end
                puts "                                                   "
                puts "#{species.name.upcase} is watching you carefully..."
                puts "                                                   "

            elsif catch_or_run == 'b'
                puts "                                                   "
                puts "You threw a piece of bait at #{species.name.upcase}"
                bait_number = rand(1..3)
                user_bait_number = rand (1..3)

                if mood == 2
                    random_number = (1..4)
                    random_user_number = (1..4)
                    puts "                                                   "
                    puts "The #{species.name.upcase} liked that."
                else
                    puts "                                                   " 
                    puts "The #{species.name.upcase} really did not like that."
                end

                if bait_number == user_bait_number
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
        puts "                                             "  
        puts "       ############              ############              ############             "
        puts "     ################          ################          ################        "
        puts "    ##################        ##################        ##################     "
        puts "   ########[ 0 ]#######      ########[ 0 ]#######      ########[ 0 ]#######  "
        puts "    ##################        ##################        ##################    "
        puts "     ################          ################          ################        "
        puts "       ############              ############              ############              "
                                         
    end


    def pc_select
        prompt = TTY::Prompt.new
        user_response = prompt.select('Would you like to release a pokemon or go back to the menu?', %w(release back))
            # user_response = gets.chomp.downcase.strip 
            if user_response == 'release'
                puts "Which pokemon would you like to release? Enter their nickname (remember nicknames are case sensitive):"
                user_nickname = gets.chomp.strip
                if self.pokemons.find_by(nickname: user_nickname)
                    self.pokemons.find_by(nickname: user_nickname).destroy
                    self.welcome
                else
                    puts "Please enter a valid nickname. Try again:"
                    self.pc_select
                end
            elsif user_response == 'back'
                self.welcome 
            else
                puts "Not a valid input try again."
                self.pc_loadup   #Old code
            end 
    end
end

