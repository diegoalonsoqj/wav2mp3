#!/bin/bash

# Script by Diego Quispe - da@diegoquispe.com
# Lima - Peru

mkdir formato_mp3

DirRaiz=$(pwd)
PesoWav=$(du -hs)

timeInit=$(date +"%d/%m/%Y %T")

let TotalAudios=$(find . -maxdepth 1 -type f -iname "*.wav" | wc -l)

for i in *.wav
do
    echo PROCESANDO $i
    lame -b 16 -m m -q 9 --resample 8 "$i" "formato_mp3/${i/.wav/.mp3}"
done


let TotalWav=$(find . -maxdepth 1 -type f -iname "*.wav" | wc -l)
echo ""
echo "ARCHIVOS WAV: "
echo "- Cantidad total de audios WAV: " $TotalWav
echo "- Peso de los audios WAV: " $PesoWav

echo ""
cd formato_mp3

PesoMp3=$(du -hs)

let TotalMp3=$(find . -maxdepth 1 -type f -iname "*.mp3" | wc -l)
echo "ARCHIVOS MP3: "
echo "- Cantidad total de audios MP3: " $TotalMp3
echo "- Peso de los audios MP3: " $PesoMp3

let difWavMp3=$TotalWav-$TotalMp3

timeFin=$(date +"%d/%m/%Y %T")

if [ $TotalWav -ne $TotalMp3 ]; then
	echo ""
	echo " ERROR - Existe un diferencia de cantidades"
	echo "- Diferencia de cantidades de archivos entre WAV y MP3: " $difWavMp3
else
	echo ""
        echo " CONVERSION DE AUDIOS EXITOSA !"
	echo "- Fecha y Hora de Inicio: " $timeInit
	echo "- Fecha y Hora de Fin: " $timeFin
       	echo "- Diferencia de cantidades de archivos entre WAV y MP3: " $difWavMp3
fi
