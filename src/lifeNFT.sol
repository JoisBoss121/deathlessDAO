// SPDX-License-Identifier: Unlicense
 pragma solidity >=0.8.0;

import "../lib/solmate/src/tokens/ERC721.sol";

library Counters{
    struct Counter {
        uint256 _value;
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        unchecked{
            counter._value += 1;
        }
    }

    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked{
            counter._value = value - 1;
        }
    }

    function reset(Counter storage counter) internal {
        counter._value = 0;
    }


}


contract lifeNFT is ERC721 {
    address immutable owner;

    mapping(uint256 => string) public tokenURIs;


    constructor(string memory name, string memory symbol) ERC721(name, symbol){
        owner = msg.sender;
    }    

    function mint(address to, uint256 id) external virtual {
        require(msg.sender==owner, "must be owner to mint");
        _mint(to, id);
    }

    function mintWithTokenURI(address to, uint256 id, string calldata _tokenURI) external virtual {
        require(msg.sender==owner, "must be owner to mint");
        _mint(to,id);
        tokenURIs[id]=_tokenURI;
    }

    function setTokenURI(string calldata _tokenURI, uint256 id) external virtual {
        require(msg.sender==owner, "must be owner to set tokenURI");
        tokenURIs[id]=_tokenURI; 
    }

    function tokenURI(uint256 id) public view override returns(string memory) {
        return tokenURIs[id];
    }

    function burn(uint256 id) external virtual {
        require(msg.sender==ownerOf[id] || msg.sender==owner, "must be owner to burn");
        _burn(id);
    }


}
