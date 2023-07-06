#!/bin/bash

# Script by Diego Quispe - da@diegoquispe.com
# Lima - Peru

if ! command -v lame &> /dev/null
then
    echo "lame no está instalado. Por favor, instálalo para continuar."
    exit
fi

if [ -d "formato_mp3" ]; then
  echo "El directorio 'formato_mp3' ya existe. ¿Quieres eliminarlo? (S/N)"
  read respuesta
  if [[ $respuesta =~ ^[Ss]$ ]]
  then
      rm -rf formato_mp3
  else
      exit 1
  fi
fi

mkdir formato_mp3

DirRaiz=$(pwd)
timeInit=$(date +"%d/%m/%Y %T")

let TotalAudios=$(find . -maxdepth 1 -type f -iname "*.wav" | wc -l)

for i in *.wav
do
    echo PROCESANDO $i
    lame -b 16 -m m -q 9 --resample 8 "$i" "formato_mp3/${i/.wav/.mp3}"
done

PesoWav=$(du -hs)

let TotalWav=$(find . -maxdepth 1 -type f -iname "*.wav" | wc -l)
echo ""
echo "ARCHIVOS WAV: "
echo "- Cantidad total de audios WAV: " $TotalWav
echo "- Peso de los audios WAV: " $PesoWav

echo ""
cd formato_mp3

PesoMp3=$(du -hs)

let TotalMp3=$(find . -maxdepth 1 -type f -iname "*.mp3" | wc -l)
echo "
