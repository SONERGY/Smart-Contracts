// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

// Libraries
import './IERC20.sol';
import './SafeMath.sol';
import './SonergyToken.sol';

interface ERC223 {
    /**
     * @dev Transfers `value` tokens from `msg.sender` to `to` address with `data` parameter
     * and returns `true` on success.
     */
    function transfer(address to, uint value, bytes memory data) external returns (bool );
     
    event Transfer(address indexed from, address indexed to, uint value, bytes indexed data);
}



contract Sonergy is SonergyToken("SNEGY", "Sonergy v2", 18, 21000000000000000000000000), IERC20, ERC223 {
    address private _owner;
  
 
    
  
    
    using SafeMath for uint;
    
 
    
    constructor() {
        _balanceOf[msg.sender] = _totalSupply;
        _owner = msg.sender;
    }
   
    
    function totalSupply() override(IERC20, SonergyToken) public view returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address _addr) override public view returns (uint) {
        return _balanceOf[_addr];
    }

    function transfer(address _to, uint _value) override public returns (bool) {
        if (_value > 0 &&
            _value <= _balanceOf[msg.sender] &&
            !isContract(_to) ) {
            _balanceOf[msg.sender] = _balanceOf[msg.sender].sub(_value);
            _balanceOf[_to] = _balanceOf[_to].add(_value);
            emit Transfer(msg.sender, _to, _value);
            return true;
        }
        return false;
    }
    
    

    function transfer(address _to, uint _value, bytes memory _data) override public returns (bool) {
        if (_value > 0 &&
            _value <= _balanceOf[msg.sender] &&
            isContract(_to)) {
            _balanceOf[msg.sender] = _balanceOf[msg.sender].sub(_value);
            _balanceOf[_to] = _balanceOf[_to].add(_value);
            
            emit Transfer(msg.sender, _to, _value, _data);
            return true;
        }
        return false;
    }
    
   
  

    function isContract(address _addr) private view returns (bool) {
        uint codeSize;
        assembly {
            codeSize := extcodesize(_addr)
        }
        return codeSize > 0;
    }

    function transferFrom(address _from, address _to, uint _value) override public returns (bool) {
        if (_allowances[_from][msg.sender] > 0 &&
            _value > 0 &&
            _allowances[_from][msg.sender] >= _value &&
            _balanceOf[_from] >= _value) {
            _balanceOf[_from] = _balanceOf[_from].sub(_value);
            _balanceOf[_to] = _balanceOf[_to].add(_value);
            _allowances[_from][msg.sender] = _allowances[_from][msg.sender].sub(_value);
            Transfer(_from, _to, _value);
            return true;
        }
        return false;
    }
    

   
    function approve(address _spender, uint _value) override public returns (bool) {
        _allowances[msg.sender][_spender] = _allowances[msg.sender][_spender].add(_value);
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _addressOwner, address _spender) override public view returns (uint) {
        return _allowances[_addressOwner][_spender];
    }
}
