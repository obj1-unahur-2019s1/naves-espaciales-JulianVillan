class NaveEspacial {
	var velocidad = 0
	var direccion = 0	
	
	method velocidad(cuanto) { velocidad = cuanto }
	method acelerar(cuanto) { velocidad = (velocidad + cuanto).min(100000) }
	method desacelerar(cuanto) { velocidad -= cuanto }
	
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol() { direccion += 1 }
	method alejarseUnPocoDelSol() { direccion -= 1 }
}

class NaveBaliza inherits NaveEspacial {
	var property color
	method cambiarColorDeBaliza(newColor) { color = newColor }
	method prepararViaje(){
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}
}

class NaveDePasajeros inherits NaveEspacial {
	var property cantPasajeros 
	var property cantComida
	var property cantBebidas
	
	method cargarComida(cant) { cantComida += cant}
	method cargarBebida(cant){ cantBebidas += cant}
	method descargarComida(cant) { cantComida -= cant}
	method descargarBebidas(cant){ cantBebidas -= cant}
	method prepararViaje(){
		self.cargarComida(4*cantPasajeros)
		self.cargarBebida(6*cantPasajeros)
		self.acercarseUnPocoAlSol()
	}
}

class NavesDeCombate inherits NaveEspacial {
	var estaVisible = true
	var misilesDesplegados = false
	var mensajesEmitidos = #{}
	
	method ponerVisible(){ estaVisible = true }
	method ponerInvisible(){ estaVisible = false }
	method estaInvisible() = not estaVisible
	
	method despegarMisiles(){ misilesDesplegados = true }
	method replegarMisiles(){ misilesDesplegados = false}
	method misilesDesplegados() = misilesDesplegados 
	
	method emitirMensaje(mensaje){ mensajesEmitidos.add(mensaje) }
	method mensajesEmitidos() = mensajesEmitidos.size()
	method primerMensajeEmitido() = mensajesEmitidos.first()
	method ultimoMensajeEmitido() = mensajesEmitidos.last()
	method esEscueta() = mensajesEmitidos.forEach{ m => m.size() }
	method emitioMensaje(mensaje) = mensajesEmitidos.any(mensaje)
	method prepararViaje(){
		self.ponerVisible()
		self.replegarMisiles()
		self.acelerar(15000)
	}
}





