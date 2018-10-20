class Deposito {
	var formaciones = #{}
	var locomotorasSueltas = #{}
	method agregarFormacion(formacion){ formaciones.add(formacion) }
	method agregarLocomotoraSuelta(locomotora){ locomotorasSueltas.add(locomotora) }
	method vagonesMasPesados() = formaciones.map { formacion => formacion.vagonMasPesado() }.asSet()
	method necesitaConductorExperimentado() = formaciones.any { formacion => formacion.esCompleja() }
	method agregarLocomotoraA(formacion){
		if(not formacion.puedeMoverse() and self._hayLocomotoraPara(formacion)){
			formacion.agregarLocomotora(self._locomotoraPara(formacion))
		}
	}
	method _locomotoraPara(formacion) = locomotorasSueltas.find { locomotora => locomotora.puedeMoverA(formacion) }
	method _hayLocomotoraPara(formacion) = locomotorasSueltas.any { locomotora => locomotora.puedeMoverA(formacion) }
}