#############################################################
# Procedimiento para  imprimir la energia potencial y o     #
# cinetica. Se requiere como datos de entrada el nombre del #
# archivo que contiene el desplazamiento o velocidad y la   #
# rigidez o masa segun se vaya a imprimir la energia        # 
# potencial o cinectica respectivamente.                    #
# El archivo que serà leido tendra en su primera columna    #
# el tiempo y las columnas siguientes corresponderan a los  #
# resultados obtenidos de la simulación.                    #
#                                                           #  
#         writeEPoteYCine [nameFile k]                      #
# nameFile: Nombre del Archivo con los resultados de la sim #          
# k: Rigidez o masa segun corresponda                       #
#                                                           #
# Escrito por: Edwin Duque                                  #
#              Santiago Quiñonez                            #
# Fecha: 14/02/2017                                         #
# Ultima revisión: 14/02/2017                               #
#############################################################

# Unidades Julios (J)

# Llama al archivo utilerias
source C:/vlee/Dinamica/377/TCLOpenSees/utilerias.tcl

	proc writeEPoteYCine {Tipo nameFile DirFileOut k} {

	# Obtiene el número de columnas del archivo
	set NumColum [getNroColumnasDes $nameFile]
	# Lee los datos del archivo nameFile
	set datos [getAllDesplazamientos $nameFile]
	# Obtiene los datos relativos de desplazamiento
	set datosRela [getRelDesplazamientos $nameFile] 

	# La primera columna es el tiempo
	set t [lindex $datosRela 0]
	# Obtiene el número de lineas
	set Nlines [llength $t]

		puts "Generando archivo energia potencial.out"
		
		  if {$Tipo == 0} {
				 set fileEnergia [open $DirFileOut/EPotencial w]
				  } else {
				  set fileEnergia [open $DirFileOut/ECinetica$i w]
				}
	

		for {set i 1} {$i <= $NumColum} {incr i 1} {
			
			  if {$Tipo == 0} {
				set desp [lindex $datosRela $i]
				} else {
				set desp [lindex $datos $i]
				}

			 set EPotencial [CalEPoteYCin $desp [lindex $k $i-1]]   
			 lappend VectEnergia $EPotenciaL	
			
				} 
				set VectEnergia
			 	
		 }
	}


proc writeEDisi {nameFile DirFileOut c} {

# Obtiene el número de columnas del archivo
set NumColum [getNroColumnasDes $nameFile]
# Obtiene los datos relativos de desplazamiento
set datosRela [getRelDesplazamientos $nameFile] 

# La primera columna es el tiempo
set t [lindex $datosRela  0]
# Obtiene el número de lineas
set Nlines [llength $t]

	puts "Generando archivo energia potencial.out"
	
	for {set i 1} {$i <= $NumColum} {incr i 1} {
		
		 puts [format "velocidad leida%01d" $i] 
		 # Genera el archivo en el que imprimen las energias 
		 set fileEDisi [open $DirFileOut/EDisi$i w]
		 set vel [lindex $datosRela  $i]

		 # Llama a la función que calcula la energia potencial
		 set EDisi [CalEDisi $t $vel [lindex $c $i-1]]
		 
		 	#Imprime las energias en columnas
			for {set j 0} {$j < $Nlines} {incr j 1} {
			
			set tiempo [lindex $t $j]
			set energia [lindex $EDisi $j]
			puts $fileEDisi "$tiempo $energia" 
			
			}
			
		 close $fileEDisi 
	 }
}