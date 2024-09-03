object pepe {
	
    var categoria = cadete
    var bonoResultado = resultadoNulo
    var bonoPresentismo = presentismoNulo
    var faltas = 0

    //var neto -> esta variable está mal, es para precalcular!


    method categoria(_categoria) {
        categoria = _categoria 
        //neto = _categoria.neto() -> Esto sería un precálculo y está mal porque el neto podría llegar a variar, ya que pepe no puede tomar decisión sobre si el neto de la categoria puede variar o no. 
    }

    method bonoResultado(_bonoResultado) {
        bonoResultado = _bonoResultado 
    } 

    method bonoPresentismo(_bonoPresentismo) {
        bonoPresentismo = _bonoPresentismo
    }

    method faltas(_faltas) {
        faltas = _faltas
    }

    method faltas() {
        return faltas
    }


    method sueldo() {
        return self.neto() + self.extraResultado() + self.extraPresentismo() 
    }


    method neto() {
        // Este tipo de if (pregunta QUIEN es el objeto) hay que reemplazarlos por polimorfismo
        // if (categoria == gerente) {
        //     return 150000
        // }
        // if (categoria == cadete) {
        //     return 200000
        // }
        // return 0 //solucion de compromiso
        

       // return neto -> Esta es la solución de precálculo (precalculé el neto cuando me pasaron la categoría. Está mal! pudo variar)

        //Esta es la solucion polimorfica! la que va!
        return categoria.neto()
    }

    method extraResultado() {
        return bonoResultado.valor(self)
    }

    method extraPresentismo() {
        return bonoPresentismo.valor(self)
    }

}

object sofia {

    var categoria = cadete
    var bonoResultado = fijo

    method categoria(_categoria) {
        categoria = _categoria
    }

    method bonoResultado(_bonoResultado) {
        bonoResultado = _bonoResultado 
    } 

    method extraResultado() {
        return bonoResultado.valor(self)
    }

    method sueldo() {
        return self.neto() + self.extraResultado()
    }

    method neto() {
        return categoria.neto() *1.3        
    }
}

object roque {
    var bonoResultado = null

    method neto() {
        return 28000
    }

    method sueldo() {
        return self.neto() + self.extraResultado() + 9000
    }

    method extraResultado() {
        return bonoResultado.valor(self)
    }

    method bonoResultado(_bonoResultado) {
        bonoResultado = _bonoResultado
    }

}

object ernesto {

    var companero = pepe
    var bonoPresentismo = null

    method bonoPresentismo (_bonoPresentismo) {
        bonoPresentismo = _bonoPresentismo
    }

    method companero(_companero) {
        companero = _companero
    }

    method neto() {
        return companero.neto()
    }

    method sueldo() {
        return self.neto() + self.extraPresentismo() 
    }

    method extraPresentismo() {
        return bonoPresentismo.valor(self)
    }

    method faltas() {
        return 0
    }
}

object medioTiempo {

    method categoriaBase(categoria) {
        categoria.neto(categoria.neto() / 2)
    }
}


object vendedor {

    var hayMuchasVentas = true

    method neto() {
      /*if (hayMuchasVentas) {
        return 16000 * 1.25
      }
      else {
        return 16000
      }*/
      return if (hayMuchasVentas) 16000 * 1.25 else 16000
    }

    method activarAumentoPorMuchasVentas() {
        hayMuchasVentas = true
    }
    
    method desactivarAumentoPorMuchasVentas() {
        hayMuchasVentas = false
    }

}

object cadete {

    var property neto = 20000
    /*
    ese property es igual a 
        method neto() {
            return neto
        }
        method neto(_neto) {
            neto = _neto
        }
    */
}

object gerente {
    method neto() {
        return 15000
    }
}

//bonos de resultado

object fijo {
    method valor(empleado) {
        return 800
    }
}

object resultadoNulo {
    method valor(empleado) {
        return 0
    }
}

object porcentaje {
    
    method valor(empleado) { //Las opciones son: pasar el empleado, la categoría o el neto, la mejor es el empleado porque defino que un bono es algo que se aplica a un empleado.
        return empleado.neto() * 0.1
    }
}  

//bonos presentismo
object presentismoNulo {
    method valor(empleado) {
        return 0
    }
}

object normal {

    method valor(empleado) {
        // if (faltas == 0) { //Estos ifs no estan mal porque no tengo una solucio polimórifca mejor. Pero se puede cambiar por una formulita haciendolo más simple
        //     return 2000
        // }
        // if (faltas == 1) {
        //     return 1000
        // }
        // return 0
        return (2000 - empleado.faltas() * 1000).max(0) //formulita más linda
    }
} 

object ajuste {
    method valor(empleado) {
        return if (empleado.faltas() == 0) 100 else 0 //usando el if como una expresion (operador ternario, funcion ifelse de intro)
        // if (faltas == 0) -> usanto el If como una estructura de control
        //    return 100
        //else
        //    return 0
    }

}

object demagogico {
    method valor(empleado) {
        return if (empleado.neto() < 18000) 500 else 300
    }
}
