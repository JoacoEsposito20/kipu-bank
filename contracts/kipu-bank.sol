// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/*
@title KipuBank
@author Joaquin Tomas Esposito
@notice Este contrato representa un banco personal.
*/
contract KipuBank{
    mapping (address usuario => uint256 saldo) private s_usuarios; //Mapa que almacena los usuarios con su saldo
    uint256 private immutable i_maxTransaccion = 1000; //Determina el maximo por transaccion
    uint256 private immutable i_bankCap; //Determina el maximo de deposito en el banco
    uint256 private nroDepositos;
    uint256 private nroRetiros;

    //@notice Evento que se lanza cuando se realiza correctamente un deposito.
    event KipuBank_DepositoRealizado(uint256);
    //@notice Evento que se lanza cuando se realiza correctamente un retiro.
    event KipuBank_RetiroRealizado(uint256);

    // Errors
    error KipuBank_MontoDeDepositoExcedido(uint256);
    error KipuBank_DepositoInvalido(uint256);
    error KipuBank_MontoTransaccionExcedido(uint256,uint256);

    // Modifiers
    modifier validarDeposito(uint256 _monto){
        uint256 balance = address(this).balance;
        if(_monto <= 0) revert KipuBank_DepositoInvalido(_monto); 
        if(_monto+balance > i_bankCap) revert KipuBank_MontoDeDepositoExcedido(balance);
        if(_monto > i_maxTransaccion) revert KipuBank_MontoTransaccionExcedido(_monto,i_maxTransaccion);
        _;
    }   


    // Functions
    function depositar()external payable validarDeposito(msg.value){
        s_usuarios[msg.sender] += msg.value;
        emit KipuBank_DepositoRealizado(msg.value);
    }


    // Constructor
    constructor(uint256 _montoBankCap){
        i_bankCap = _montoBankCap;  
        nroDepositos = 0;
        nroRetiros = 0;
    }

    // Receive & Fallback
    receive() external payable { }
    fallback() external{}

    // External
    // Public
    // Internal
    // Private
    // View & Pure  


}
