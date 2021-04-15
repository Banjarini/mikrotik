#:global telegramMessage
#import the decode script
/system script run "decode"
# set variables
:local botid
:local chatid
:local bal [:toarray ""]
:global urlEncode

#go to telegram and create group and add bot
#Find group id through https://api.telegram.org/bot1537508402:AAFqjSTEy1hUPBzt1Nc0rsQoDFe1wlguUnQ/getUpdates
:set botid "1537508402:AAFqjSTEy1hUPBzt1Nc0rsQoDFe1wlguUnQ"
:set chatid "1568681651"

# dial your operator code *171# netone *171# econet
/interface lte at-chat input="AT+CUSD=1,\"*171#\",15" wait=yes lte1

# option 7
/interface lte at-chat input="AT+CUSD=1,\"7\",15" wait=yes lte1

# option 7
:set bal [/interface lte at-chat input="AT+CUSD=1,\"7\",15" wait=yes lte1 as-value]

#change to a string for processing
:set bal [:tostr $bal]

#pick the relevant information
:local test [:pick $bal ([:find $bal "USD"]+8) ([:len $bal]-3)]
# run the decode script
:local test [$urlEncode $test]
:put $test

# send the telegram
if ($balfinal != "") do={ /tool fetch url="https://api.telegram.org/bot$botid/sendMessage\?chat_id=$chatid&text=$test " keep-result=no
   #set telegramMessage ""
}


#to run script /system script run bal
#add to scheduler to run at 07:30:00
