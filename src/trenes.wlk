class Formacion {
	var vagones = #{}
	const property locomotoras = #{}
	var property ciudadOrigen
	var property ciudadDestino
	method agregarLocomotora(locomotora){ locomotoras.add(locomotora) }
	method agregarVagon(vagon){ vagones.add(vagon) }
	method cantidadDePasajerosQuePuedeTransportar() = vagones.sum { vagon => vagon.cantidadMaximaDePasajeros() }
	method cantidadDeVagonesLivianos() = vagones.count { vagon => vagon.pesoMaximo() < 2500 }
	method velocidadMaxima() = locomotoras.min { locomotora => locomotora.velocidadMaxima() }.velocidadMaxima()
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
	method cantidadDeBanios() = vagones.sum { vagon => vagon.cantidadDeBanios() }
}

class FormacionCortaDistancia inherits Formacion {
	const property limiteDeVelocidad = 60
	method estaBienArmada() = self.puedeMoverse() and not self.esCompleja()
	override method velocidadMaxima() = limiteDeVelocidad.min(super())
}

class FormacionLargaDistancia inherits Formacion {
	method estaBienArmada() = self.puedeMoverse() and self.tieneSuficientesBanios()
	method tieneSuficientesBanios() = self.cantidadDeBanios() >= (self.cantidadDePasajerosQuePuedeTransportar()/50)
	method limiteDeVelocidad() = if(ciudadOrigen.tamanio() == "Grande" and ciudadDestino.tamanio() == "Grande") 200 else 150
	override method velocidadMaxima() = self.limiteDeVelocidad().min(super())
}

class FormacionAltaVelocidad inherits FormacionLargaDistancia{
	override method limiteDeVelocidad() = 400
	override method estaBienArmada() = self.puedeMoverse() and self.esVeloz() and self.esLiviana()
	method esVeloz() = self.velocidadMaxima() >= 250
	method esLiviana() = vagones.size() == self.cantidadDeVagonesLivianos()
}
