class VagonDePasajeros {
	var property largo = 0
	var property anchoUtil = 0
	var property cantidadDeBanios = 0
	method cantidadMaximaDePasajeros() = if(anchoUtil < 2.5) largo * 8 else largo * 10
	method pesoMaximo() = self.cantidadMaximaDePasajeros() * 80
}

class VagonDeCarga {
	var property cargaMaxima = 0
	method pesoMaximo() = cargaMaxima + 160
	method cantidadMaximaDePasajeros() = 0
	method cantidadDeBanios() = 0
}

class Locomotora {
	var property peso = 0
	var property pesoMaximoQuePuedeArrastrar = 0
	var property velocidadMaxima = 0
	method arrastreUtil()= pesoMaximoQuePuedeArrastrar - peso
	method puedeMoverA(formacion) = self.arrastreUtil() >= formacion.kilosDeEmpujeFaltantesParaMoverse()
}

