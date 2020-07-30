class User < ActiveRecord::Base
    has_many :pokemons
    def self.sign_up
        prompt = TTY::Prompt.new
        username = prompt.ask("Please enter a username:") 
        
        password = prompt.mask("Please enter a password:")
         
        gender = prompt.select("What is your gender?", %w(male female non-binary))
        
        trainer_name = prompt.ask("Please enter your trainer name:")
        user = User.create(username: username, password: password, gender: gender, trainer_name: trainer_name, currency: 160, balls: 20)
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

    
    def inventory
        User.all.reload
        total_currency = self.currency
        puts "////////////////////////////////////////////////////////////////////////////"
        puts "|--------------------------------------------------------------------------|"
        puts "  MONEY: ¥ #{total_currency}"
        puts "|--------------------------------------------------------------------------|"
        puts "  SAFARI BALLS: #{self.balls}"
        puts "|--------------------------------------------------------------------------|"
        puts "////////////////////////////////////////////////////////////////////////////"
        prompt = TTY::Prompt.new
        user_response = prompt.select('Would you like to go back to the main menu?', %w(Yes No))
        if user_response == 'Yes'
            self.welcome 
        elsif user_response == 'No'
            self.inventory
        end
    end 

    def shop
        prompt = TTY::Prompt.new
        total_currency = self.currency   
        puts " _____________________________________"  
        puts "                                      "   
        puts " MONEY: ¥ #{total_currency}          "              
        puts " -------------------------------------" 
        puts " SAFARI BALLS: #{self.balls}          "         
        puts " _____________________________________"
        user_decision = prompt.select("What would you like to do?", %w(BUY_ONE_BALL LEAVE))
       if user_decision == "BUY_ONE_BALL"
        
    
        if self.currency > 19
            self.currency -= 20
            self.balls += 1
            self.save 
            self.shop
        elsif self.currency < 19 && self.balls == 0
            puts "HEY! You don't have the money for this. You know what I'll be nice and give you 10 balls on the house."
            self.balls += 10
            self.save 
            self.shop
        else 
            puts "HEY! You don't have the money for this. You still have some Safari Balls left go catch a Pokémon!"
            self.shop
        end   

       elsif user_decision == "LEAVE"

           self.welcome
       end
    end

   
     def welcome
         prompt = TTY::Prompt.new
         user_decision = prompt.select("What would you like to do?", %w(CATCH_POKEMON PC POKÉMART BAG QUIT))
        
        
        if user_decision == "CATCH_POKEMON"

            self.catch_pokemon

        elsif user_decision == "PC"

            self.pc_loadup

        elsif user_decision == "POKÉMART"

            self.shop

        elsif user_decision == "BAG"

            self.inventory

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
            puts "|--------------------------------------------------------------------------|"
            puts " STAT TOTAL: #{pokemon.species.stat}"
            puts "|--------------------------------------------------------------------------|"
            puts "////////////////////////////////////////////////////////////////////////////"
         end
    
        
        if self.pokemons.count > 0
            puts "                                   "
            puts "POKÉMON COUNT: #{pokemons.count}"
            self.poke_ball 
            self.pc_select_sell  
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
        species.stat += rand(0..20)
        mood = rand(1..2)
        random_number = rand(1..2)
        random_user_number = rand(1..2)
        until self.balls == 0 do
            puts "You encounter a wild #{species.name.upcase}. You have #{self.balls} safari balls left."
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
                escape_number = rand(1..3)
                escape_user_number = rand(1..3)  
                self.balls -= 1
                self.save 
                if random_number == random_user_number
                    puts "Congratulations! You caught a #{species.name.upcase} " #wanted to create a new method but needed to grab species name
                    puts "Please enter a nickname for your pokemon:"
                    nickname = gets.chomp.strip
                    Pokemon.create(nickname: nickname, user_id: self.id, species_id: species.id)
                    self.welcome
                elsif escape_number == escape_user_number
                    puts "Wild #{species.name.upcase} has fled!"
                    puts "                                                   " 
                    self.welcome 
                else
                    puts "Oh, no! The #{species.name.upcase} broke free!"
                end

            elsif catch_or_run == 'r'
                puts "                                                   "
                puts "You threw a rock at #{species.name.upcase}"
                escape_number = rand(1..2)
                escape_user_number = rand(1..2)
                if mood == 1
                    random_number = rand(1..2)
                    random_user_number = rand(1..2)
                    puts "                                                   "
                    puts "The #{species.name.upcase} liked that."
                    puts "                                                   " 
                else
                    puts "                                                   " 
                    puts "The #{species.name.upcase} really did not like that."
                    puts "                                                   " 
                end

                if escape_number == escape_user_number
                    puts "Wild #{species.name.upcase} has fled!"
                    puts "                                                   " 
                    self.welcome 
                end
                puts "                                                   "
                puts "#{species.name.upcase} is watching you carefully..."
                puts "                                                   "

            elsif catch_or_run == 'b'
                puts "                                                   "
                puts "You threw a piece of bait at #{species.name.upcase}"
                escape_number = rand(1..2)
                escape_user_number = rand(1..2)

                if mood == 2
                    random_number = rand(1..2)
                    random_user_number = rand(1..2)
                    puts "                                                   "
                    puts "The #{species.name.upcase} liked that."
                    puts "                                                   "
                else
                    puts "                                                   " 
                    puts "The #{species.name.upcase} really did not like that."
                    puts "                                                   "
                end

                if escape_number == escape_user_number
                    puts "Wild #{species.name.upcase} has fled!"
                    puts "                                                   "
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
        if self.balls == 0
            puts "You have no safari balls. Go buy some!"
            self.welcome 
        end
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


    def pc_select_sell 
        prompt = TTY::Prompt.new
        user_response = prompt.select('Would you like to sell a pokemon, release a pokemon or go back to the menu?', %w(RELEASE SELL MENU))
            # user_response = gets.chomp.downcase.strip 
            if user_response == 'RELEASE'
                if self.pokemons.count == 0
                    puts "Looks like you don't have any pokemon. Go catch some!"
                    self.welcome 
                end
                puts "Which pokemon would you like to release? Enter their nickname (remember nicknames are case sensitive):"
                user_nickname = gets.chomp.strip
                if self.pokemons.find_by(nickname: user_nickname)
                    self.pokemons.find_by(nickname: user_nickname).destroy
                    self.pc_select_sell
                else
                    puts "Please enter a valid nickname. Try again:"
                    self.pc_select_sell
                end
            elsif user_response == "SELL"
                if self.pokemons.count == 0
                    puts "Looks like you don't have any pokemon. Go catch some!"
                    self.welcome 
                end
                puts "Which pokemon would you like to sell? Enter their nickname (remember nicknames are case sensitive):"
                user_nickname = gets.chomp.strip
                if self.pokemons.find_by(nickname: user_nickname)
                    sold_pokemon = self.pokemons.find_by(nickname: user_nickname)
                    self.currency += sold_pokemon.species.stat 
                    self.save 
                    self.pokemons.find_by(nickname: user_nickname).destroy
                    puts "You sold #{sold_pokemon.nickname} for ¥#{sold_pokemon.species.stat}"
                    puts "TOTAL MONEY: ¥ #{self.currency}"
                    self.pc_select_sell
                else  
                    puts "Please enter a valid nickname. Try again:"
                    self.pc_select_sell
                end              
            elsif user_response == 'MENU'
                self.welcome 
            else
                puts "Not a valid input try again."
                self.pc_loadup   #Old code
            end 
    end
end
 
