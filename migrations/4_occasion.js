const Gifting = artifacts.require("Gifting");

module.exports = function (deployer) {
  deployer.deploy(Gifting);
};
