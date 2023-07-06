#!/bin/bash

# Script by Diego Quispe - da@diegoquispe.com
# Lima - Peru

LOG_FILE="conversion.log"

check_lame_installed() {
  if ! command -v lame &> /dev/null
  then
      echo "lame no está instalado. Por favor, instálalo para continuar." | tee -a $LOG_FILE
      exit 1
  fi
}

handle_existing_dir() {
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
}

count_files() {
  local type=$1
  find . -maxdepth 1 -type f -iname "*.${type}" | wc -l
}

convert_files() {
  local total_files=$(count_files wav)
  local count=0
  for i in *.wav
  do
      echo -n "Procesando archivo ${i}... " | tee -a $LOG_FILE
      if lame -b 16 -m m -q 9 --resample 8 "$i" "formato_mp3/${i/.wav/.mp3}"
      then
          echo "OK" | tee -a $LOG_FILE
          let count++
      else
          echo "Error al convertir archivo ${i}" | tee -a $LOG_FILE
      fi
      echo "Progreso: ${count}/${total_files}" | tee -a $LOG_FILE
  done
}

report() {
  local type=$1
  echo "" | tee -a $LOG_FILE
  echo "ARCHIVOS ${type^^}: " | tee -a $LOG_FILE
  echo "- Cantidad total de audios ${type^^}: $(count_files ${type})" | tee -a $LOG_FILE
  echo "- Peso de los audios ${type^^}: $(du -hs)" | tee -a $LOG_FILE
}

# Remove log file if exists
if [ -f "$LOG_FILE" ] ; then
    rm "$LOG_FILE"
fi

check_lame_installed
handle_existing_dir

timeInit=$(date +"%d/%m/%Y %T")

convert_files

timeFin=$(date +"%d/%m/%Y %T")

cd formato_mp3

report wav
report mp3

let difWavMp3=$(count_files wav)-$(count_files mp3)

if [ $difWavMp3 -ne 0 ]; then
  echo "" | tee -a $LOG_FILE
  echo " ERROR - Existe una diferencia de cantidades" | tee -a $LOG_FILE
  echo "- Diferencia de cantidades de archivos entre WAV y MP3: " $difWavMp3 | tee -a $LOG_FILE
else
  echo "" | tee -a $LOG_FILE
  echo " CONVERSION DE AUDIOS EXITOSA !" | tee -a $LOG_FILE
  echo "- Fecha y Hora de Inicio: " $timeInit | tee -a $LOG_FILE
  echo "- Fecha y Hora de Fin: " $timeFin | tee -a $LOG_FILE
  echo "- Diferencia de cantidades de archivos entre WAV y MP3: " $difWavMp3 | tee -a $LOG_FILE
fi
