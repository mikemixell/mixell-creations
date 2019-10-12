pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./Factory.sol";
import "./Mixell.sol";
import "./Strings.sol";

contract MixellFactory is Factory, Ownable {
  using Strings for string;

  address public proxyRegistryAddress;
  address public nftAddress;
  string public baseURI = "https://api.mixell.de/";

  /**
   * Three different options for minting Mixells (basic, premium, and gold).
   */
  uint256 NUM_OPTIONS = 3;
  uint256 SINGLE_MIXELL_OPTION = 0;
  uint256 MULTIPLE_MIXELL_OPTION = 1;
  uint256 NUM_MIXELLS_IN_MULTIPLE_MIXELL_OPTION = 4;

  constructor(address _proxyRegistryAddress, address _nftAddress) public {
    proxyRegistryAddress = _proxyRegistryAddress;
    nftAddress = _nftAddress;
  }

  function name() external view returns (string memory) {
    return "Mixell Mixell";
  }

  function symbol() external view returns (string memory) {
    return "MXL";
  }

  function supportsFactoryInterface() public view returns (bool) {
    return true;
  }

  function numOptions() public view returns (uint256) {
    return NUM_OPTIONS;
  }
  
  function mint(uint256 _optionId, address _toAddress) public {
    // Must be sent from the owner proxy or owner.
    ProxyRegistry proxyRegistry = ProxyRegistry(proxyRegistryAddress);
    assert(address(proxyRegistry.proxies(owner())) == msg.sender || owner() == msg.sender);
    require(canMint(_optionId));

    Mixell mixellArtworkMixell = Mixell(nftAddress);
    if (_optionId == SINGLE_MIXELL_OPTION) {
      mixellArtworkMixell.mintTo(_toAddress);
    } else if (_optionId == MULTIPLE_MIXELL_OPTION) {
      for (uint256 i = 0; i < NUM_MIXELLS_IN_MULTIPLE_MIXELL_OPTION; i++) {
        mixellArtworkMixell.mintTo(_toAddress);
      }
    } 
  }

  function canMint(uint256 _optionId) public view returns (bool) {
    if (_optionId >= NUM_OPTIONS) {
      return false;
    }

    Mixell mixellArtworkMixell = Mixell(nftAddress);
    uint256 MixellSupply = mixellArtworkMixell.totalSupply();
/**
    uint256 numItemsAllocated = 0;
    if (_optionId == SINGLE_MIXELL_OPTION) {
      numItemsAllocated = 1;
    } else if (_optionId == MULTIPLE_MIXELL_OPTION) {
      numItemsAllocated = NUM_MIXELLS_IN_MULTIPLE_MIXELL_OPTION;
    } 
    return MixellSupply < (Mixell_SUPPLY - numItemsAllocated);
     */
     return true;
  }


  function tokenURI(uint256 _optionId) external view returns (string memory) {
    return Strings.strConcat(
        baseURI,
        Strings.uint2str(_optionId)
    );
  }

  /**
   * Hack to get things to work automatically on OpenSea.
   * Use transferFrom so the frontend doesn't have to worry about different method names.
   */
  function transferFrom(address _from, address _to, uint256 _tokenId) public {
    mint(_tokenId, _to);
  }

  /**
   * Hack to get things to work automatically on OpenSea.
   * Use isApprovedForAll so the frontend doesn't have to worry about different method names.
   */
  function isApprovedForAll(
    address _owner,
    address _operator
  )
    public
    view
    returns (bool)
  {
    if (owner() == _owner && _owner == _operator) {
      return true;
    }

    ProxyRegistry proxyRegistry = ProxyRegistry(proxyRegistryAddress);
    if (owner() == _owner && address(proxyRegistry.proxies(_owner)) == _operator) {
      return true;
    }

    return false;
  }

  /**
   * Hack to get things to work automatically on OpenSea.
   * Use isApprovedForAll so the frontend doesn't have to worry about different method names.
   */
  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return owner();
  }
}
