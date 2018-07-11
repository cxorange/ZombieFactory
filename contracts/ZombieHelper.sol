pragma solidity ^0.4.17;

import "./ZombieFeeding.sol";

contract ZombieHelper is ZombieFeeding{
    uint levelUpFee = 0.001 ether;
	
	modifier aboveLevel(uint _level, uint _zombieId){
	    require(zombies[_zombieId].level >= _level);
	    _;
	}

	function withDraw()external onlyOwner{
	   owner.transfer(this.balance);
	}
	function levelUp(uint _zombieId) external payable{
	    require(msg.value == levelUpFee);
	    zombies[_zombieId].level++;
	}
    function setLevelUp(uint _fee) external onlyOwner{
       levelUpFee = _fee;
    }

	function changeName(uint _zombieId, string newName) external aboveLevel(2 , _zombieId) ownerOf(_zombieId){
	   zombies[_zombieId].name = newName;
	}

	function changeDna(uint _zombieId, uint newDna) external aboveLevel(20, _zombieId) ownerOf(_zombieId){
	   zombies[_zombieId].dna = newDna;
	}

	function getZombiesByOwner(address _owner) external view returns(uint[]){
	  uint[] memory result = new uint[](ownerZombieCount[_owner]);
	  uint counter = 0;
	  for(uint i = 0; i < zombies.length; i++){
	      if(zombies[i] == _owner){
	         result[counter] = i;
	         counter++;
	      }
	  }

	  return result;
	} 
}