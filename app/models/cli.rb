
class Cli
    def self.start
        self.pic_two
        prompt = TTY::Prompt.new
        user_login_input = prompt.select("Welcome to Poké Safari!", %w(sign-up sign-in))
        #user_login_input = gets.chomp.strip 
        
        if user_login_input == "sign-up"
            User.sign_up
            start
        elsif user_login_input == "sign-in"
            user = User.sign_in
            if user
                puts "Welcome back #{user.username}!"
                user.welcome

            else 
                puts "Sorry we could not find you. Try signing up first:"
                start
            end    
        else
            puts "Sorry that's not a valid option try again:"
            start
        end
    end
    def self.pic_two
        puts"
        
        8 888888888o       ,o888888o.     8 8888     ,88' 8 8888888888                d888888o.           .8.          8 8888888888       .8.          8 888888888o.    8 8888 
        8 8888    `88.  . 8888     `88.   8 8888    ,88'  8 8888                    .`8888:' `88.        .888.         8 8888            .888.         8 8888    `88.   8 8888 
        8 8888     `88 ,8 8888       `8b  8 8888   ,88'   8 8888                    8.`8888.   Y8       :88888.        8 8888           :88888.        8 8888     `88   8 8888 
        8 8888     ,88 88 8888        `8b 8 8888  ,88'    8 8888                    `8.`8888.          . `88888.       8 8888          . `88888.       8 8888     ,88   8 8888 
        8 8888.   ,88' 88 8888         88 8 8888 ,88'     8 888888888888             `8.`8888.        .8. `88888.      8 888888888888 .8. `88888.      8 8888.   ,88'   8 8888 
        8 888888888P'  88 8888         88 8 8888 88'      8 8888                      `8.`8888.      .8`8. `88888.     8 8888        .8`8. `88888.     8 888888888P'    8 8888 
        8 8888         88 8888        ,8P 8 888888<       8 8888                       `8.`8888.    .8' `8. `88888.    8 8888       .8' `8. `88888.    8 8888`8b        8 8888 
        8 8888         `8 8888       ,8P  8 8888 `Y8.     8 8888                   8b   `8.`8888.  .8'   `8. `88888.   8 8888      .8'   `8. `88888.   8 8888 `8b.      8 8888 
        8 8888          ` 8888     ,88'   8 8888   `Y8.   8 8888                   `8b.  ;8.`8888 .888888888. `88888.  8 8888     .888888888. `88888.  8 8888   `8b.    8 8888 
        8 8888             `8888888P'     8 8888     `Y8. 8 888888888888            `Y8888P ,88P'.8'       `8. `88888. 8 8888    .8'       `8. `88888. 8 8888     `88.  8 8888   "
        puts ""
        puts ""
        puts "                                                     
                            `.......` 
                   `.:/osydmmmmmmmmmmmdhys+:.`        
                 `:+ydddhso/::-.....-:/+oyhmmmmmho/. 
              `:sddyo:.`                   `-/shmmmmho:`
              -sdho:`                            `.:ohdddho:` 
              `/yds:`                                   `./sdddds:`              
              /hdo-                                          `:sdddds/. 
             .oyo.                                              `.+hddddy/.  
             -sy:                                                   .oddddddy/.       `::.                                           -//-             `           
             .ss-                                                      :hddddddys/.    .osss+-`                                   `-/oooo+         `.-/:`          
             +y:                                                        .oyhhhhhhhys/.  +osss/--`                               .:-/++yys.     `-:::-./.           
             `ys`                                                              oyhhhddd. soos:` .:-                           `--``/sshy/  `-/:-.`````/`           
             -yo                                                                hhhyhhhhy-sso/..``-/`                       `.``.../yhh+`.-:.`  `````./            
             .ss`                     .---.`      ``````                          hhdhhhhd-oso....``::                     .-``..../hhho/.```````````-:            
              os/                    -dmNmmds/:+shhddddhys+-`                       hhddhdd`+s......`./.                  -.`......oy+-``````..```` `/.            
              .os:                   smNNmmmdmNNNNNNNNNNNNNmds/.```                    hhddd-+:......./- `.-:---::/:-.` -`....`.:o/````.```````````.+`            
               .+s/`                 ymmmNNNNNNNNNNNNNNNNNNNmmmdhhhys+:                       `:+/.....`///:-........:///-.....-//.``...``.````````.-:             
                `:oo-`               sdmNNNNNNNNNNNNNNNNNNNNmmmmmmmNmmm`                        `-//-..`..................`.-/+/.``.........`.......//             
                  ./o+-`             +dmNNNNNNNNNNNNNNNNNNmmmmmmmmmmmds                           `:-`......................./:``....`..............o/`            
                    .:oo/-`         /mmmmmhhmNmNNNNNNNNNmmmmmmmmmmmmhy.                          ./.``:o//:...........-//+/...++.............-:////:o-             
                     `-/o+/:.`    :mmmmyyh+ydhdNNNmmmmmmddmmddmmmmmy-                           .+. `/dh:/y:..........ys-sho...s+.......-::/::-.`   -`             
                        `.:+o+/:-`hmmmhhN+sN+dymmmmmmmmdydyyo+smmmmy                            +- `./hhyhy:..........yhhhh+...:y...-:::-.`                        
                            `.-/+-dmmmoMM/++:ymmmmmmmmmhd+oMh/dsmmmm.                           o../:::++/-...../-....-/++/:/:--h..+.`                             
                                  +dmmshN/oo+ymmmmmmmmmms/+s/+Mommmm:                           +:osoo/....::/+osso+/:..../so/-/h`.::                              
                                   -ydmdhoosohmmmmmmmmmm+soo+mNommmm.                           .o+oooo.....-oyyyyyh:.....+sso/y+.`.//                             
                                     -ohmmdddmmmmmmmmmmmooo+ohydmmmo--.`                         -o/++/`.....-soooy+....../o++yy`...`++`                           
                                  `.::/+oo:mmmmmmmmmmmmmmddmmmmmds: .-:+o+/-                      `:/.`.......-+oo/.``....-:++/o:`...-+o`                          
                                -dmmdhyyyo+dmmmmmmmmmmmydhhyso:`        .:os/`                      +---.................-//o+::-...--:+-                          
                                `sssso++++/:shmmmmmmhy++oossyhho/.`        -os:                    .:   `  `................-s..-:://-.`                           
                                           `so++oooosss++shdmmmmmmd-         +y/                  `+`   ``.-....``...........o+--o:`                               
                                        .--+ysssssyyyhy`  ``-:oymdo-         `sy`                 -:    `..-:.......-/```....:y-.-o.                               
                                     ./sysohhyyyyyhhhhh:        --           :yo                  /``    `.`/-...`../`  ....-.y+:--:`                              
                                    +yhhhyhhhhhhhhhhhhhds.                 `/yo.                 ./``-   `...+...../:  `..-/:.+ys/--/`                             
                                   /yhhhyhhhhhhhhhhhhdmmmd+            `.:+ss:`                  /. `-/` `...o-....s  `..-/+..:syo:.`                              
                                  `yyyyshhhhhhhhhhhhhmmmmmdo`---:://+oooo+/.`                    o` ..-+-``..:s-..o: `..-++...-++                                  
                                  `syyyoyhhhhhhhhhyydmmmmmmd:oooo++//:.``                       .+  ....++--:o/.../o---:o:.....:+                                  
                                   :syyoyyyhhhhhhyshhdddmddh/.````                              :: `.....-///-.....-/++/-....../s                                  
                                    -oyosyyyyyyyy/hhhhhhhhhh:                                   -: `........................--.:y`                                 
                                     `-o++syyyyyy/yhhhhhhhhs`                                   `+```....................-.--..+o                                  
                                      :sso//ossyy/yyyhhhhy+`                                     -+-`.................----...-+s`                                  
                                     -syyy:  `....oyyyys+-                                        -so/---.---::///::-----.-:+yo`                                   
                                    /yyyys`      +sso+:.                                            -+:/:/oso::-..````.-::oyo+/:-y+                                   
                                   /syyyy:      .yyyo`                                              oyyooo/`               ./oo+ssh.                                   
                                   +yysy/       +yyy-                                               `--.                      `.---                                  
                                   `/+-.       -yyys                                                                            
                                              `syyy+                            
                                              +yyyy:        
                                              :yyyyy:  
                                             .yyyyyy:                                                 By Kevin Xie and Ryan Flynn
                                            `syhhhhy-                                                       Mod. 1 Project
                                             /ohhoo.                                                   
                                              `-..                    "
        puts "                            "
        puts "                             "                                                            

    end
end