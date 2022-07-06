#!/bin/bash
#••••••••••••••••••••••••••••••••••••••••
#••         Regular font colors       •••
#••••••••••••••••••••••••••••••••••••••••
# Black font                            #
function blackFont(){                   #
  echo -e "\033[30m$1\033[0m"           #
}                                       #
                                        #
## Red font                             #
function redFont(){                     #
  echo -e "\033[31m$1\033[0m"           #
}                                       #
                                        #
### Green font                          #
function greenFont(){                   #
  echo -e "\033[32m$1\033[0m"           #
}                                       #
                                        #
#### Yellow font                        #
function yellowFont(){                  #
  echo -e "\033[33m$1\033[0m"           #
}                                       #
                                        #
##### Blue font                         #
function blueFont(){                    #
  echo -e "\033[34m$1\033[0m"           #
}                                       #
                                        #
###### Purple font                      #
function purpleFont(){                  #
  echo -e "\033[35m$1\033[0m"           #
}                                       #
                                        #
####### Skyblue font                    #
function skyBlueFont(){                 #
  echo -e "\033[36m$1\033[0m"           #
}                                       #
                                        #
######## white font                     #
function whiteFont(){                   #
  echo -e "\033[37m$1\033[0m"           #
}                                       #
#••••••••••••••••••••••••••••••••••••••••

#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
#∞∞          Bold font colors          ∞∞
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
# Black bold font                       #
function blkBoldFont(){                 #
  echo -e "\033[1;30m$1\033[0m"         #
}                                       #
                                        #
# Red bold font                         #
function redBoldFont(){                 #
  echo -e "\033[1;31m$1\033[0m"         #
}                                       #
                                        #
# Green bold font                       #
function greenBoldFont(){               #
  echo -e "\033[1;32m$1\033[0m"         #
}                                       #
                                        #
# Yellow bold font                      #
function yellowBoldFont(){              #
  echo -e "\033[1;33m$1\033[0m"         #
}                                       #
                                        #
# Blue bold font                        #
function blueBoldFont(){                #
  echo -e "\033[1;34m$1\033[0m"         #
}                                       #
                                        #
# Purple bold font                      #
function purpleBoldFont(){              #
  echo -e "\033[1;35m$1\033[0m"         #
}                                       #
                                        #
# Skyblue bold font                     #
function skyBlueBoldFont(){             #
  echo -e "\033[1;36m$1\033[0m"         #
}                                       #
                                        #
# White bold font                       #
function whiteBoldFont(){               #
  echo -e "\033[1;37m$1\033[0m"         #
}                                       #
#∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞

#££££££££££££££££££££££££££££££££££££££££
#££         underline font colors      ££
#££££££££££££££££££££££££££££££££££££££££
# Black underline font                  #
function h1BlackUndFont(){              #
  echo -e "\033[1;4;30m$1\033[0m"       #
}                                       #
                                        #
# Red underline font                    #
function h1RedUndFont(){                #
  echo -e "\033[1;4;31m$1\033[0m"       #
}                                       #
                                        #
# Green underline font                  #
function h1GreenUndFont(){              #
  echo -e "\033[1;4;32m$1\033[0m"       #
}                                       #
                                        #
# Yellow underline font                 #
function h1YellowUndFont(){             #
  echo -e "\033[1;4;33m$1\033[0m"       #
}                                       #
                                        #
# Blue underline font                   #
function h1BlueUndFont(){               #
  echo -e "\033[1;4;34m$1\033[0m"       #
}                                       #
                                        #
# Purple underline font                 #
function h1PurpleUndFont(){             #
  echo -e "\033[1;4;35m$1\033[0m"       #
}                                       #
                                        #
# Skyblue underline font                #
function h1SkyblueUndFont(){            #
  echo -e "\033[1;4;36m$1\033[0m"       #
}                                       #
                                        #
# White underline font                  #
function h1WhiteUndFont(){              #
  echo -e "\033[1;4;37m$1\033[0m"       #
}                                       #
#££££££££££££££££££££££££££££££££££££££££

#¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡
#!!       Blink font colors            ¡¡
#¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡
# Blink black colors                    #
function BlkBlackFont(){                #
  echo -e "\033[1;5;30m$1\033[0m"       #
}                                       #
                                        #
# Blink red colors                      #
function BlkRedFont(){                  #
  echo -e "\033[1;5;31m$1\033[0m"       #
}                                       #
                                        #
# Blink green colors                    #
function BlkGreenFont(){                #
  echo -e "\033[1;5;32m$1\033[0m"       #
}                                       #
                                        #
# Blink yellow colors                   #
function BlkYellowFont(){               #
  echo -e "\033[1;5;33m$1\033[0m"       #
}                                       #
                                        #
# Blink blue colors                     #
function BlkBlueFont(){                 #
  echo -e "\033[1;5;34m$1\033[0m"       #
}                                       #
                                        #
# Blink purple colors                   #
function BlkPurpleFont(){               #
  echo -e "\033[1;5;35m$1\033[0m"       #
}                                       #
                                        #
# Blink skyblue colors                  #
function BlkSkyblueFont(){              #
  echo -e "\033[1;5;36m$1\033[0m"       #
}                                       #
                                        #
# Blink white colors                    #
function BlkWhiteFont(){                #
  echo -e "\033[1;5;37m$1\033[0m"       #
}                                       #
function example(){
  echo -e "0\t$(blackFont "blackFont: EXAMPLE")\t\tVS\t$(blkBoldFont "blkBoldFont: EXAMPLE")"
  echo -e "1\t$(redFont "redFont: EXAMPLE")\t\tVS\t$(redBoldFont "redBoldFont: EXAMPLE")"
  echo -e "3\t$(yellowFont "yellowFont: EXAMPLE")\t\tVS\t$(yellowBoldFont "yellowBoldFont: EXAMPLE")"
  echo -e "4\t$(blueFont "blueFont: EXAMPLE")\t\tVS\t$(blueBoldFont "blueBoldFont: EXAMPLE")"
  echo -e "5\t$(purpleFont "purpleFont: EXAMPLE")\t\tVS\t$(purpleBoldFont "purpleBoldFont: EXAMPLE")"
  echo -e "6\t$(skyBlueFont "skyBlueFont: EXAMPLE")\t\tVS\t$(skyBlueBoldFont "skyBlueBoldFont: EXAMPLE")"
  echo -e "7\t$(whiteFont "whiteFont: EXAMPLE")\t\tVS\t$(whiteBoldFont "whiteBoldFont :EXAMPLE")"
  echo
  echo -e "8\t$(h1BlackUndFont "h1BlackUndFont: EXAMPLE")\t\tVS\t$(BlkBlackFont "BlkBlackFont: EXAMPLE")"
  echo -e "9\t$(h1RedUndFont "h1RedUndFont: EXAMPLE")\t\tVS\t$(BlkRedFont "BlkRedFont: EXAMPLE")"
  echo -e "10\t$(h1GreenUndFont "h1GreenUndFont: EXAMPLE")\t\tVS\t$(BlkGreenFont "BlkGreenFont: EXAMPLE")"
  echo -e "11\t$(h1YellowUndFont "h1YellowUndFont: EXAMPLE")\tVS\t$(BlkYellowFont "BlkYellowFont: EXAMPLE")"
  echo -e "12\t$(h1BlueUndFont "h1BlueUndFont: EXAMPLE")\t\tVS\t$(BlkBlueFont "BlkBlueFont: EXAMPLE")"
  echo -e "13\t$(h1PurpleUndFont "h1PurpleUndFont: EXAMPLE")\tVS\t$(BlkPurpleFont "BlkPurpleFont: EXAMPLE")"
  echo -e "13\t$(h1SkyblueUndFont "h1SkyblueUndFont: EXAMPLE")\tVS\t$(BlkSkyblueFont "BlkSkyblueFont: EXAMPLE")"
  echo -e "14\t$(h1WhiteUndFont "h1WhiteUndFont: EXAMPLE")\t\tVS\t$(BlkWhiteFont "BlkWhiteFont: EXAMPLE")"
}
