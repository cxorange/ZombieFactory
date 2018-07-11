// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";

// Import libraries we need.
import { default as Web3} from 'web3';
import { default as contract } from 'truffle-contract'

// Import our contract artifacts and turn them into usable abstractions.
import zombiefactory_artifacts from '../../build/contracts/ZombieFactory.json'

// MetaCoin is our usable abstraction, which we'll use through the code below.
var ZombieFactory = contract(zombiefactory_artifacts);

window.createZombie  = function(){
  let ownerName = $("#ownerName").val();
  
  $("#cz").html("Zombie has been submitted. Please wait.");
  ZombieFactory.deployed().then(function(contractInterface){
    contractInterface.createRandomZombie(ownerName,{gas:470000,from:web3.eth.accounts[0]});
  })
}



function generateZombie(id , name , dna){
  console.log('-----' + id + '-----' + name + '------' + dna);
}
$(document).ready(function(){
  if (typeof web3 != 'undefined') {
    window.web3 = new Web3(web3.currentProvider);
  }else{
    window.web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));
  }
  ZombieFactory.setProvider(web3.currentProvider);

  var event = ZombieFactory.deployed().then(function(contractInterface){

     contractInterface.NewZombie(function(error, result){
        $("#cz").html("");
        console.log("======");
        if (error) {
          return;
        }
        var values = result["args"];
        generateZombie(values.zombieId,values.name,values.dna);
     })
  })
});
