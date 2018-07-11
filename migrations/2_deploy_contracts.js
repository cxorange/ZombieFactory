var ZombieFactory = artifacts.require("./ZombieFactory.sol");
var ZombieFeeding = artifacts.require("./ZombieFeeding.sol");
module.exports = function(deployer) {

  deployer.deploy(ZombieFactory);//0xa51351c0a5b4b7a6d2ab29986f867a0a48224d9d
  deployer.deploy(ZombieFeeding);//0x55e31a7a97d8adb903beb2a4152ef9c0969913bb
};
