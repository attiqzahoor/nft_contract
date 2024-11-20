CustomNFT Smart Contract
A simple ERC721 NFT contract that allows minting, transferring, and managing NFTs with customizable metadata. This contract includes functionality to extract a symbol from the URI and manage token transfers.

Features
ERC721 Compliance: Implements the ERC721 standard for non-fungible tokens.
Minting: Allows minting of NFTs with unique URIs.
URI Handling: Supports the setting and retrieving of token URIs.
Symbol Extraction: Extracts a symbol from the URI provided during minting.
Token Transfer: Supports standard ERC721 token transfers.
Contract Overview
Name: CustomNFT
Symbol: CNFT
Functions:
safeMint(address to, uint256 tokenId, string memory uri): Mint a new token with a specified URI.
getSymbolFromURI(string memory uri): Extract a symbol from a URI.
tokenURI(uint256 tokenId): Retrieve the URI associated with a token.
transferFrom(address from, address to, uint256 tokenId): Transfer ownership of a token.
approve(address to, uint256 tokenId): Approve an address to transfer a specific token.
setApprovalForAll(address operator, bool approved): Approve or revoke approval for an operator to transfer all tokens of the sender.
ownerOf(uint256 tokenId): Get the owner of a token.
Prerequisites
To deploy and interact with this contract, you need:

Solidity Compiler: Version ^0.8.4 or higher.
Ethereum Wallet: e.g., MetaMask, for deploying the contract and interacting with it.
Web3 Provider: e.g., MetaMask, or a local Ethereum network like Ganache.
IDE: Remix (web-based IDE) or a local development environment such as Truffle or Hardhat.
Installation
Set Up Remix:

Open Remix IDE.
Create a new file, e.g., NFT.sol, and paste the contract code into the file.
Compile the contract using Remix's Solidity compiler.
Deploy Contract:

In the "Deploy & Run Transactions" panel, select your contract (NFT).
Choose the environment (e.g., Injected Web3 for MetaMask, or JavaScript VM for testing).
Click "Deploy."
Interact with the Contract:

After deployment, Remix will show your contract's deployed address and available functions in the "Deployed Contracts" section.
Contract Usage
Minting a Token
To mint a new NFT, call the safeMint function with the following parameters:

to: The address where the token will be minted.
tokenId: A unique identifier for the token.
uri: A URI where the metadata for the token is stored (e.g., a URL to an image, JSON metadata, etc.).
solidity
Copy code
safeMint("0xRecipientAddressHere", 1, "https://my-nft-metadata-uri.com/unique-symbol");
Extracting the Symbol from a URI
If you need to extract a symbol from the URI, call the getSymbolFromURI function. It returns the symbol from the URI based on the format specified in the contract (the symbol comes after the first /).

solidity
Copy code
getSymbolFromURI("https://my-nft-metadata-uri.com/unique-symbol");
This will return the symbol unique-symbol.

Retrieving Token URI
To retrieve the URI associated with a specific token, use the tokenURI function with the tokenId.

solidity
Copy code
tokenURI(1);  // Returns "https://my-nft-metadata-uri.com/unique-symbol"
Transferring a Token
To transfer a token from one address to another, use the transferFrom function:

solidity
Copy code
transferFrom("0xSenderAddressHere", "0xRecipientAddressHere", 1);
This will transfer the token with tokenId 1 from the sender's address to the recipient's address.

Approving a Transfer
To approve an address to transfer a specific token on your behalf, use the approve function:

solidity
Copy code
approve("0xApprovedAddressHere", 1);
This will allow the address 0xApprovedAddressHere to transfer the token with tokenId 1.

Setting Operator Approval
To approve or revoke an operator from managing your tokens, use the setApprovalForAll function:

solidity
Copy code
setApprovalForAll("0xOperatorAddressHere", true);  // Approve
setApprovalForAll("0xOperatorAddressHere", false); // Revoke approval
Getting Token Owner
To get the owner of a specific token, use the ownerOf function:

solidity
Copy code
ownerOf(1);  // Returns the owner's address of tokenId 1
Contract Details
Name: attiq
Symbol: atq
Total Supply: Unlimited (you can mint as many tokens as you want).
Minting Owner: Only the owner of the contract can mint new tokens.
Security Considerations
Ensure that the minting function (safeMint) is only accessible to trusted users, as it is currently open to all users (by default, in the example it is open to the contract owner).
Implement additional checks for URI validity and ensure the metadata at the URI is accurate and secure.
License
This contract is licensed under the MIT License.
