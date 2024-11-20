
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract CustomNFT {
    string public name = "attiq";
    string public symbol = "atq";
    
    // Mapping from token ID to owner address
    mapping(uint256 => address) private _owners;
    
    // Mapping from token ID to URI
    mapping(uint256 => string) private _tokenURIs;
    
    // Mapping from address to balance (number of tokens owned)
    mapping(address => uint256) private _balances;

    // Mapping from token ID to approval address
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    
    // Event for minting new tokens
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    constructor() {}

    // Mint function
    function safeMint(address to, uint256 tokenId, string memory uri) public {
        require(to != address(0), "Mint to the zero address");
        require(!_exists(tokenId), "Token already minted");

        _owners[tokenId] = to;
        _tokenURIs[tokenId] = uri;
        _balances[to] += 1;

        emit Transfer(address(0), to, tokenId);
    }

    // Get symbol from URI function
    function getSymbolFromURI(string memory uri) public pure returns (string memory) {
        bytes memory uriBytes = bytes(uri);
        
        uint256 startIdx = 0;
        uint256 endIdx = uriBytes.length;

        // Search for the symbol within the URI, you can adjust the format depending on how the symbol is structured
        for (uint256 i = 0; i < uriBytes.length; i++) {
            if (uriBytes[i] == "/") {
                startIdx = i + 1;
                break;
            }
        }

        // Collect the symbol starting from startIdx
        bytes memory symbolBytes = new bytes(endIdx - startIdx);
        uint256 symbolIndex = 0;
        for (uint256 i = startIdx; i < endIdx; i++) {
            symbolBytes[symbolIndex] = uriBytes[i];
            symbolIndex++;
        }

        return string(symbolBytes);
    }

    // Returns the URI of a given token
    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "Token does not exist");
        return _tokenURIs[tokenId];
    }

    // Check if a token exists
    function _exists(uint256 tokenId) internal view returns (bool) {
        return _owners[tokenId] != address(0);
    }

    // Transfer function (standard ERC721 transfer)
    function transferFrom(address from, address to, uint256 tokenId) public {
        require(from == msg.sender || _isApprovedOrOwner(msg.sender, tokenId), "Not approved or owner");
        require(to != address(0), "Transfer to the zero address");

        _transfer(from, to, tokenId);
    }

    // Internal transfer function
    function _transfer(address from, address to, uint256 tokenId) internal {
        _owners[tokenId] = to;
        _balances[from] -= 1;
        _balances[to] += 1;

        emit Transfer(from, to, tokenId);
    }

    // Approve address to transfer token
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner, "Approval to current owner");

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    // Returns the owner of a token
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "Token does not exist");
        return owner;
    }

    // Internal check if sender is approved or owner
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    // Get approved address for token
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId), "Token does not exist");
        return _tokenApprovals[tokenId];
    }

    // Approve or revoke operator for all tokens
    function setApprovalForAll(address operator, bool approved) public {
        require(operator != msg.sender, "Approve to caller");

        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    // Check if an operator is approved for all tokens of an owner
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }
}
