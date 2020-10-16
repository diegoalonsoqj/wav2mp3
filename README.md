# wav2mp3
Script simple en bash para convertir audios de formato WAV a audios en MP3.

  Requerimientos:

1.- El script usa como nucleo el software lame para conversion de formato en archivos de audio, de no tenerlo instalado bastaria con ejecutar:

      yum install -y lame
      apt install -y lame
      
   * Elegir uno u otro gestor de paquetes dependiendo de la distribucion de su Sistema Operativo.


  Guia de uso:

1.- Descargar y copiar el archivo .sh que contiene el script en la carpeta donde se ubican los archivos de audio en formato .WAV.
2.- Brindarle permisos de ejecucion al archivo wav2mp3.sh con el siguiente comando:

    chmod +x wav2mp3.sh
    
3.- Ejecutar el archivo con alguna de las siguientes maneras:

    ./wav2mp3.sh
    bash wav2mp3.sh
    
4.- El resultado final sera una carpeta nueva en la misma ubicacion en donde se ejecuto el archivo wav2mp3.sh que sera contenedor de los archivos nuevos en formato MP3.
