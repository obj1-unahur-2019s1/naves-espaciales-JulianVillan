class NaveEspacial {
	var velocidad = 0
	var direccion = 0
	var combustible
	
	method velocidad(cuanto) { velocidad = cuanto }
	method acelerar(cuanto) { velocidad = (velocidad + cuanto).min(100000) }
	method desacelerar(cuanto) { velocidad -= cuanto }
	
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol() { direccion += 1 }
	method alejarseUnPocoDelSol() { direccion -= 1 }
	
	method cargarCombustible(cant) { combustible += cant }
	method descargarCombustible(cant) { combustible -= cant }
	
	method prepararViaje() { self.cargarCombustible(30000) ; self.acelerar(5000) }	
	method estaTranquila() = combustible >= 4000 && velocidad <= 12000
}

class NaveBaliza inherits NaveEspacial {
	var property color
	method cambiarColorDeBaliza(newColor) { color = newColor }
	override method prepararViaje(){
		super()
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}
	method recibirAmenaza(){
		self.irHaciaElSol()
		self.cambiarColorDeBaliza("rojo")
	}
	override method estaTranquila() = super() && color != "rojo"
}

class NaveDePasajeros inherits NaveEspacial {
	var property cantPasajeros 
	var property cantComida
	var property cantBebidas
	
	method cargarComida(cant) { cantComida += cant}
	method cargarBebida(cant){ cantBebidas += cant}
	method descargarComida(cant) { cantComida -= cant}
	method descargarBebida(cant){ cantBebidas -= cant}
	override method prepararViaje(){
		super()
		self.cargarComida(4*cantPasajeros)
		self.cargarBebida(6*cantPasajeros)
		self.acercarseUnPocoAlSol()
	}
	method recibirAmenaza(){
		self.velocidad(velocidad*2)
		self.descargarComida(cantPasajeros)
		self.descargarBebida(cantPasajeros*2)
	}
	
}

class NaveDeCombate inherits NaveEspacial {
	var estaVisible = true
	var misilesDesplegados = false
	var mensajesEmitidos = []
	
	method ponerVisible(){ estaVisible = true }
	method ponerInvisible(){ estaVisible = false }
	method estaInvisible() = not estaVisible
	
	method desplegarMisiles(){ misilesDesplegados = true }
	method replegarMisiles(){ misilesDesplegados = false}
	method misilesDesplegados() = misilesDesplegados 
	
	method emitirMensaje(mensaje){ mensajesEmitidos.add(mensaje) }
	method mensajesEmitidos() = mensajesEmitidos
	method primerMensajeEmitido() = mensajesEmitidos.first()
	method ultimoMensajeEmitido() = mensajesEmitidos.last()
	method esEscueta() = mensajesEmitidos.all{ m => m.size() <= 30 }
	method emitioMensaje(mensaje) = mensajesEmitidos.contains(mensaje)
	override method prepararViaje(){
		super()
		self.ponerVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en mision")
	}
	method recibirAmenaza(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
		self.emitirMensaje("Amenaza recibida")
	}
	override method estaTranquila() = super() && not misilesDesplegados
}

class NaveHospital inherits NaveDePasajeros {
	var quirofanos = false
	
	method quirofanosPreparados() = quirofanos
	override method recibirAmenaza(){
		super()
		quirofanos = true
	}
	override method estaTranquila() = super() && not quirofanos
}

class NaveDeCombateSigilosa inherits NaveDeCombate {
	override method recibirAmenaza(){
		super()
		self.desplegarMisiles()
		self.ponerInvisible()
	}
	override method estaTranquila() = super() && estaVisible
}



