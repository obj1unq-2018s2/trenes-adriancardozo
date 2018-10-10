class Formacion {
	var vagones = #{}
	var locomotoras = #{}
	method agregarLocomotora(){}
	method cantidadDePasajerosQuePuedeTransportar() = vagones.sum { vagon => vagon.cantidadMaximaDePasajeros() }
	method cantidadDeVagonesLivianos() = vagones.count { vagon => vagon.pesoMaximo() < 2500 }
	method esEficiente() = locomotoras.all { locomotora => locomotora.peso() * 5 <= locomotora.pesoMaximoQuePuedeArrastrar() }
	method puedeMoverse() = self._arrastreUtilTotal() >= self._pesoMaximoTotalVagones()
	method kilosDeEmpujeFaltantesParaMoverse() = if(self.puedeMoverse()) 0 else self._pesoMaximoTotalVagones() - self._arrastreUtilTotal()
	method _pesoMaximoTotalVagones() = vagones.sum { vagon => vagon.pesoMaximo() }
	method _arrastreUtilTotal() = locomotoras.sum { locomotora => locomotora.arrastreUtil() }
	method vagonMasPesado() = vagones.max { vagon => vagon.pesoMaximo() }
	method esCompleja() = self.unidades() > 20 or self.pesoTotal() > 10000
	method pesoTotal() = self._pesoLocomotoras() + self._pesoMaximoTotalVagones()
	method unidades() = vagones.size() + locomotoras.size()
	method _pesoLocomotoras() = locomotoras.sum { locomotora => locomotora.peso() }
}
class VagonDePasajeros {
	var property largo = 0
	var property anchoUtil = 0
	method cantidadMaximaDePasajeros() = if(anchoUtil < 2.5) largo * 8 else largo * 10
	method pesoMaximo() = self.cantidadMaximaDePasajeros() * 80
}

class VagonDecarga {
	var property cargaMaxima = 0
	method pesoMaximo() = cargaMaxima + 160
	method cantidadMaximaDePasajeros() = 0
}

class Locomotora {
	var property peso = 0
	var property pesoMaximoQuePuedeArrastrar = 0
	var property velocidadMaxima = 0
	method arrastreUtil()= pesoMaximoQuePuedeArrastrar - peso
}

class Deposito {
	var formaciones = #{}
	var locomotorasSueltas = #{}
	method vagonesMasPesados() = formaciones.map { formacion => formacion.vagonMasPesado() }.asSet()
	method necesitaConductorExperimentado() = formaciones.any { formacion => formacion.esCompleja() }
	method agregarLocomotoraA(formacion)
}