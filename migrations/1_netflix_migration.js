
const Netflix = artifacts.require("Netflix");

module.exports = function (deployer) {
  deployer.deploy(Netflix);
};
