const Occasion = artifacts.require("Occasion");

module.exports = function (deployer) {
  deployer.deploy(Occasion);
};
