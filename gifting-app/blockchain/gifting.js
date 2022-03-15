import ContractJson from "../../build/contracts/Gifting.json";

/* Contract instance with all its methods and events  */
const giftingContract = web3 => {
    if (!('abi' in ContractJson) ||  ContractJson.abi == undefined) throw "Compile Truffle contract"
    if (!('networks' in ContractJson) || !('5777' in ContractJson.networks)) throw "Migrate the truffle contract to Rinkeby test network"

    const rinkebyContractAddress = ContractJson.networks[5777].address;
    return new web3.eth.Contract(ContractJson.abi, rinkebyContractAddress);
}

export default giftingContract;