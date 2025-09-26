// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/*
@title KipuBank
@author Joaquin Tomas Esposito
@notice Este contrato representa un banco personal.
*/
contract KipuBank{
    uint256 private s_bovedaPersonal = 0; //Variable que representa la boveda personal
    uint256 private immutable s_umbralTransaccion = 10; //Constante que define el maximo por transaccion
    uint256 private immutable s_bankCap; //Constante que determina el maximo de deposito. Se define en tiempo de deploy. 

    event KipuBank_montoDepositado(string mensaje);
    event KipuBank_montoRetirado(string mensaje);

    /*
    @notice Funcion para depositar saldo.
    @param _monto es el monto que se quiere depositar.
    */
    function depositar(uint256 _monto) external {
        
        if(_monto < s_bankCap && _monto > 0){
            s_bovedaPersonal = s_bovedaPersonal + _monto;
            emit KipuBank_montoDepositado("Monto depositado");
        }else{
            //¿Cargar umbral y aclarar que no se cargo todo o no cargar?
        }
    }

    /*
    @notice Funcion para retirar saldo.
    @param _monto es el monto que se quiere retirar.
    */
    function retirar(uint256 _monto) external {
        if(validarRetiro(_monto)){
            s_bovedaPersonal = s_bovedaPersonal - _monto;
            emit KipuBank_montoRetirado("Monto retirado");
        }
    }

    /*
    @notice Funcion para consultar el saldo en la boveda.
    @return monto_ es el monto disponible.
    */
    function consultarSaldo() external view returns (uint256 monto_){
        monto_ = s_bovedaPersonal;
    }

    /*
    @notice Funcion para validar retiro.
    @param _monto es el monto que se quiere retirar.
    @return es_valido_ es la validacion.
    */
    function validarRetiro(uint256 _monto) private view returns (bool es_valido_){
        if(_monto <= s_umbralTransaccion && _monto <= s_bovedaPersonal && _monto > 0){
            return true;
        }else{
            if(_monto <= 0){
                //ERROR: monto no valido
                return false;
            }else{
                if(_monto >= s_umbralTransaccion){
                    //ERROR: Se sobrepasa el umbral de transaccion
                    return false;
                }else{
                    //ERROR: No hay saldo suficiente
                    return false;
                }
            }
        }
    }
}
