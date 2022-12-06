#!/bin/bash


# Copier le fichier de configuration sur le serveur

cp ./config__files/ssh/sshd_config /etc/ssh/sshd_config

cp ./config__files/ssh/Banner /etc/Banner


# Redemarrer le service sshd 

systemctl restart sshd

#Création d'utilisateur

printf "Donnez le nom de l'utilisateur à créer :\n"

read user

useradd -m -d/home/$user -s /bin/bash -c "$user" $user && passwd $user && usermod -aG sudo $user && echo -e $user "est devenu un superUser !\n"


#Insertion de la clé public

printf "Entrez la clé public de l'utilisateur : \n"

read key

echo $key >> tmp_authorized_keys.txt

cat tmp_authorized_keys.txt >> ~/.ssh/authorized_keys && echo -e "\e[1;33mClé ssh ajouté\e[0m \n"
rm tmp_authorized_keys.txt && echo -e "\e[1;31mFichier temporaire de clé supprimé\e[0m \n"
sleep 1
service sshd restart && echo -e "\e[1;32mOpération effectuée....\e[0m \n"
