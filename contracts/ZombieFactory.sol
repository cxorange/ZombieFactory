pragma solidity ^0.4.17;
import "./Ownable.sol";
contract ZombieFactory is Ownable{
    //新僵尸创建完成触发的事件
    event NewZombie(uint zombieId, string name, uint dna);
	uint dnaDigits  = 16;
	uint dnaModulus = 10 ** dnaDigits;
	uint cooldownTime = 1 days;
	struct Zombie{
	   string name;
	   uint dna;
	   uint32 level;
	   uint32 readyTime;
	   uint16 winCount;
	   uint16 lossCount;
	}

	
	//结构体数组
	Zombie[] public zombies;
	//属于谁的僵尸,id跟地址绑定
	mapping(uint => address) zombieToOwner;
	//地址下僵尸数量
	mapping(address => uint) ownerZombieCount;

	//创建僵尸
	function _createZombie(string _name, uint _dna) internal{
	    uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime),0,0)) - 1;
	    zombieToOwner[id] = msg.sender;
	    ownerZombieCount[msg.sender]++;
	    NewZombie(id , _name , _dna);
	}
	//创建僵尸Dna
	function _generateRandomDna(string _name) private view returns(uint){
	    uint rand = uint(keccak256(_name));

	    return rand % dnaModulus;
	}
	//创建僵尸
	function createRandomZombie(string name) public{
	    require(ownerZombieCount[msg.sender] >= 0);
	    uint randDna = _generateRandomDna(name);
	    randDna = randDna - randDna % 100;
	    _createZombie(name , randDna);
	}
}