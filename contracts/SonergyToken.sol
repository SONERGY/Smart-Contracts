// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

contract SonergyToken {
    string internal _symbol;
    string internal _name;
    uint internal _decimals;
    uint internal _totalSupply = 21000000000000000000000000;
    mapping (address => uint) _balanceOf;
    mapping (address => mapping (address => uint)) internal _allowances;

    constructor (string memory __symbol, string memory __name, uint __decimals, uint __totalSupply) {
        _symbol = __symbol;
        _name = __name;
        _decimals = __decimals;
        _totalSupply = __totalSupply;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint) {
        return _decimals;
    }

    function totalSupply() virtual public view returns (uint) {
        return _totalSupply;
    }

   
}

