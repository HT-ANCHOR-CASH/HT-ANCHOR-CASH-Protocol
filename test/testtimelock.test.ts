import { ethers } from 'hardhat';
import { ParamType } from 'ethers/lib/utils';

function encodeParameters(
    types: Array<string | ParamType>,
    values: Array<any>
  ) {
    const abi = new ethers.utils.AbiCoder();
    return abi.encode(types, values);
}

const data = encodeParameters(['address'], ["0x021e0529ddcd7F50Ff45F4E9a42FCb29C9e16806"]);
console.log(data,"___________________----------------------")