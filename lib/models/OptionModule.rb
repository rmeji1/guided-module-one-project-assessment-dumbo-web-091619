require_relative "monster.rb"
module OptionModule
  module Options
    FIGHT = "fight"
    FOUNTION = "fountain"
    GO_AGAIN = "go_again"
    OPTIONS = [FIGHT, FOUNTION] 
    private_constant :FIGHT, :FOUNTION, :GO_AGAIN
  end

  module FoutainChoices
    DRINK = "Drink!"
    WALK_AWAY = "Leave the water alone!"
    FOUNTION_PROMPT = "You have come across the fountian of youth! Would you like to"
    FOUNTION_CHOICES = [DRINK, WALK_AWAY]
  end

  module FightChoices
    FIGHT_CHOICE = "Fight!"
    RUN = "Run away!"
    FIGHT_PROMPT = "Oh no! You see an #{Monster.all.map(&:name).sample} in front of you. Do you fight or run away?"
    FIGHT_CHOICES = [FIGHT_CHOICE, RUN]
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