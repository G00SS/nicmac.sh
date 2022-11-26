#!/bin/bash

##################################################################
#  Récupération de l'adresse MAC de l'interface réseau d'une IP  #
##################################################################
#                                                                #
#            SYNOPSYS : ./nicmac.sh <IP.à.chercher>              #
#                                                    G0osS 2022  #
##################################################################

# Si l'OS utilise ip
if [[ -f "/bin/ip" || -f "/sbin/ip" ]]; then
    # Récupération du numéro de la ligne concernant l'IP
    linenum=`ip -br addr show | awk '/'$1'/{ print NR; exit }'`
    # Récupération de la mac à cette même ligne dans une autre commande
    nicmac=`ip -br link show | awk 'NR=="'$linenum'" {print;exit}' | awk '{print $3}'`

# Sinon l'OS utilise ifconfig
elif [ -f "/sbin/ifconfig" ]; then
    nicmac=`ifconfig -a | awk -vRS= -vORS='\n\n' '/'$1'/' | grep "ether" | tr -s ' ' | cut -d ' ' -f3`

# Sinon... Je ne sais pas
else
    nicmac=""
fi

# Affichage du résultat
echo "$1"' <=> '"$nicmac"
