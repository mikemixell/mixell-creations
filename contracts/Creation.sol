pragma solidity ^0.5.0;

import "./TradeableERC721Token.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
 * @title Creation
 * Creation - a contract for my non-fungible creations.
 */
contract Creation is TradeableERC721Token {
  constructor(address _proxyRegistryAddress) TradeableERC721Token("Creation", "OSC", _proxyRegistryAddress) public {  }

  function baseTokenURI() public view returns (string memory) {
    return "https://api.mixell.de/";
  }
}
