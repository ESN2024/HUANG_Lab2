# HUANG_Lab2

## Introduction
Cette conception réalise une fonction de comptage sur la carte DE10-Lite, en utilisant le langage C pour le développement logiciel, et est mise en œuvre dans Quartus. Ce design inclut NIOS II, RAM, UART, PIO, et Timer. La conception est divisée en trois parties : la première partie utilise un compteur d'un chiffre, dont la valeur est affichée sur un afficheur numérique d'un chiffre et augmente de 0 à 9. La deuxième partie utilise un compteur de trois chiffres, dont la valeur augmente de 0 à 999, affichée sur trois afficheurs numériques, avec une augmentation toutes les secondes. La troisième partie utilise un TIMER qui génère une interruption toutes les secondes. Un compteur supplémentaire est ajouté au cœur logiciel, augmentant de 1 toutes les secondes jusqu'à un maximum de 999, et sa valeur est affichée sur un afficheur numérique de trois chiffres.

La valeur du compteur sur le cœur logiciel est d'abord conçue dans la partie logicielle pour convertir le décimal en BCD, en utilisant la programmation en langage C. Ensuite, elle est transmise hors du système QSYS par le biais du PIO. Dans la partie FPGA, un module de conversion binaire en afficheur numérique est écrit en langage VHDL. Ce module est appelé trois fois pour afficher respectivement les valeurs des centaines, dizaines et unités du compteur. La valeur finale du compteur est affichée sur l'afficheur numérique.

## System Architecture
Notre conception de sortie PIO utilise une sortie PIO de 12 bits. Pour cette sortie de 12 bits, chaque groupe de 4 bits est connecté à un code VHDL pour la conversion binaire en afficheur numérique, correspondant respectivement aux centaines, dizaines et unités du compteur. Le schéma de la conception est illustré dans la figure 3.  
![Description](figure3.png)

La communication entre NIOS et les différents modules se fait par le biais du bus spécialisé Avalon d'Inter, comme indiqué dans l'AVMM de la figure. La commande de chaque appareil se fait par la lecture et l'écriture de son adresse. Notre conception est divisée en trois parties : les première et deuxième parties sont réalisées grâce à un délai produit par la fonction usleep(). 
Dans la première partie, nous avons écrit une variable de type int en C, qui compte de 0 à 9 en boucle, puis affiche cette valeur sur l'afficheur numérique. 
La deuxième partie est similaire à la première, sauf que notre variable compte de 0 à 999 en boucle. 
La troisième partie consiste en un TIMER générant une interruption toutes les secondes, avec le compteur augmentant de 1 chaque seconde. La valeur maximale du compteur est de 999, et chaque code BCD nécessite une largeur de 4 bits, donc la sortie PIO est de 12 bits de large.

## Progress Results
En observant les valeurs sur l'afficheur numérique, notre projet conçu a réalisé dans la première partie une augmentation du compteur de 0 à 9, et la vitesse peut être modifiée dans la fonction usleep() de la partie logicielle. 

https://github.com/ESN2024/HUANG_Lab2/assets/94178929/ba56ec66-af5c-4779-9a6b-d18c1a583a65

La deuxième partie a réalisé un cycle de comptage de 0 à 999, avec un intervalle d'augmentation de 1 seconde. 

https://github.com/ESN2024/HUANG_Lab2/assets/94178929/19efdc14-caa5-4c7b-98a1-227ad7b5dcaf

Dans notre troisième partie, à chaque interruption générée par le Timer, le compteur augmente de 1, correspondant à notre 1 seconde, l'afficheur numérique augmente également de 1. 
Le phénomène expérimental de la troisième partie est identique à celui de la deuxième partie. Pour le troisième projet, notre interruption est générée toutes les secondes, puis la valeur du compteur est transmise hors de NIOS. Ensuite, dans le code C, nous réinitialisons la valeur de l'interruption à 0, et le compteur recommence à compter, réalisant ainsi une interruption toutes les secondes et par conséquent, la fonctionnalité d'augmentation de la valeur du compteur de 1 chaque seconde.

## Conclusion
Ce projet permet de bien comprendre le principe de fonctionnement des afficheurs numériques, ainsi que le processus de développement pour FPGA et NIOS II. Ce projet nous a également appris les fonctions courantes des timers et des interruptions. Nous avons appris comment construire un système QSYS et nous sommes familiarisés avec les fonctions HAL. Dans la partie logicielle, nous avons appris à convertir les nombres décimaux en codes BCD, et à utiliser la fonction usleep() pour ajouter un délai. Dans la partie matérielle, nous avons appris à convertir les nombres binaires pour les afficher sur un afficheur numérique.

La réalisation de la fonctionnalité s'est faite étape par étape : tout d'abord, nous avons appris à utiliser le code VHDL pour convertir un nombre binaire en valeur pour un afficheur numérique. Ensuite, dans la partie logicielle, nous avons d'abord créé un compteur à un chiffre, allant de 0 à 9 en boucle. Bien que cela puisse sembler simple, c'était tout de même un défi. Puis, nous avons implémenté un cycle de 0 à 999, ce qui n'était pas difficile grâce à l'expérience acquise auparavant. Le défi résidait dans la nécessité de séparer les valeurs des centaines, dizaines et unités du compteur, puis de les transmettre via une sortie PIO de 12 bits. Dans la partie C, nous avons utilisé les opérateurs % et / pour extraire les centaines, dizaines et unités. Nous avons finalement réussi à implémenter la fonctionnalité. Le défi de la troisième partie résidait dans l'utilisation appropriée des interruptions. Dans la partie logicielle, j'ai conçu le système pour augmenter la valeur du compteur à chaque interruption et pour écrire cette valeur dans le PIO, qui est ensuite affichée sur l'afficheur numérique. Les résultats expérimentaux finaux montrent que c'était une approche raisonnable. Finalement, les résultats expérimentaux des deuxième et troisième parties étaient cohérents, et la fonctionnalité a été complétée avec succès.
