const Mixell = artifacts.require("./Mixell.sol");
const MixellFactory = artifacts.require("./MixellFactory.sol")

module.exports = function(deployer, network) {
  // OpenSea proxy registry addresses for rinkeby and mainnet.
  let proxyRegistryAddress = ""
  if (network === 'rinkeby') {
    proxyRegistryAddress = "0xf57b2c51ded3a29e6891aba85459d600256cf317";
  } else {
    proxyRegistryAddress = "0xa5409ec958c83c3f309868babaca7c86dcb077c1";
  }

  deployer.deploy(Mixell, proxyRegistryAddress, {gas: 5000000});
  
  // Uncomment this if you want initial item sale support.
  // deployer.deploy(Mixell, proxyRegistryAddress, {gas: 5000000}).then(() => {
  //   return deployer.deploy(MixellFactory, proxyRegistryAddress, Mixell.address, {gas: 7000000});
  // }).then(async() => {
  //   var Mixell = await Mixell.deployed();
  //   return Mixell.transferOwnership(MixellFactory.address);
  // })
};