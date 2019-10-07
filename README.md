## Mixell Creations ERC721 contract

### About Mixell Creations

This is a ERC721 based on the example of the [OpenSea](https://opensea.io) marketplace. 

Additionally, this contract whitelists the proxy accounts of OpenSea users so that they are automatically able to trade the ERC721 item on OpenSea (without having to pay gas for an additional approval). On OpenSea, each user has a "proxy" account that they control, and is ultimately called by the exchange contracts to trade their items. (Note that this addition does not mean that OpenSea itself has access to the items, simply that the users can list them more easily if they wish to do so)
