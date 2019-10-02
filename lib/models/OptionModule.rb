require_relative "monster.rb"
module OptionModule
  module Options
    NORTH = "North"
    EAST = "East"
    SOUTH = "South"
    WEST = "West"
    
    FIGHT = "fight"
    FRIEND_OR_FOE = "friend_or_foe"
    
    RIVER = "river"
    CAVE = "cave"
    OPTIONS = [FIGHT, FRIEND_OR_FOE, RIVER, CAVE, FIGHT] 

    # private_constant :FIGHT, :GO_AGAIN
  end

  module FightChoices
    FIGHT_CHOICE = "Fight!"
    RUN = "Run away!"
    # Would like to be able to say #{monster.name} instead of monster in the line below
    FIGHT_PROMPT = "Oh no! You see a monster in front of you. Do you fight or run away?"
    FIGHT_CHOICES = [FIGHT_CHOICE, RUN]
  end

  module FriendOrFoe
    FRIEND_OR_FOE_PROMPT = "You meet a stranger in the forest. Do you trust them or run away?"
    FRIEND_TRUST = "Trust them!"
    FRIEND_RUN_AWAY = "Run away!"
    FRIEND_OR_FOE_CHOICES = [FRIEND_TRUST, FRIEND_RUN_AWAY]
  end

  module RiverChoices
    RIVER_PROMPT = "You face a rushing river. Do you try to jump over it or walk around?"
    RIVER_JUMP_OVER = "Jump over"
    RIVER_WALK_AROUND = "Walk around"
    RIVER_CHOICES = [RIVER_JUMP_OVER, RIVER_WALK_AROUND]
  end

  module CaveChoices
    CAVE_PROMPT = "You spot a dark cave. Do you check it out or keep walking?"
    CAVE_CHECKOUT = "Check out the cave"
    CAVE_KEEP_WALKING = "Keep walking"
    CAVE_CHOICES = [CAVE_CHECKOUT, CAVE_KEEP_WALKING]
  end

  # ORGE_IMAGE = "X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
  # |                           ,,'``````````````',,                            |
  # X                        ,'`                   `',                          X
  # |                      ,'                         ',                        |
  # X                    ,'          ;       ;          ',                      X
  # |       (           ;             ;     ;             ;     (               |
  # X        )         ;              ;     ;              ;     )              X
  # |       (         ;                ;   ;                ;   (               |
  # X        )    ;   ;    ,,'```',,,   ; ;   ,,,'```',,    ;   ;               X
  # |       (    ; ',;   '`          `',   ,'`          `'   ;,' ;              |
  # X        )  ; ;`,`',  _--~~~~--__   ' '   __--~~~~--_  ,'`,'; ;     )       X
  # |       (    ; `,' ; :  /       \~~-___-~~/       \  : ; ',' ;     (        |
  # X  )     )   )',  ;   -_\  o    /  '   '  \    o  /_-   ;  ,'       )   (   X
  # | (     (   (   `;      ~-____--~'       '~--____-~      ;'  )     (     )  |
  # X  )     )   )   ;            ,`;,,,   ,,,;',            ;  (       )   (   X
  # | (     (   (  .  ;        ,'`  (__ '_' __)  `',        ;  . )     (     )  |
  # X  )     \/ ,".). ';    ,'`        ~~ ~~        `',    ;  .(.", \/  )   (   X
  # | (   , ,'|// / (/ ,;  '        _--~~-~~--_        '  ;, \)    \|', ,    )  |
  # X ,)  , \/ \|  \\,/  ;;       ,; |_| | |_| ;,       ;;  \,//  |/ \/ ,   ,   X
  # |",   .| \_ |\/ |#\_/;       ;_| : `~'~' : |_;       ;\_/#| \/| _/ |.   ,"  |
  # X#(,'  )  \\\#\ \##/)#;     :  `\/       \/   :     ;#(\##/ /#///  (  ',)# ,X
  # || ) | \ |/ /#/ |#( \; ;     :               ;     ; ;/ )#| \#\ \| / | ( |) |
  # X\ |.\\ |\_/#| /#),,`   ;     ;./\_     _/\.;     ;   `,,(#\ |#\_/| //.| / ,X
  # | \\_/# |#\##/,,'`       ;     ~~--|~|~|--~~     ;       `',,\##/#| #\_// \/|
  # X  ##/#  #,,'`            ;        ~~~~~        ;            `',,#  #\##  //X
  # |####@,,'`                 `',               ,'`                 `',,@####| |
  # X#,,'`                        `',         ,'`                        `',,###X
  # |'  spb                          ~~-----~~                               `' |
  # X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
  # "
end