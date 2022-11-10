// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {MerkleProof} from "@oz/utils/cryptography/MerkleProof.sol";

contract MerkleVerification {
    error InvalidProof();

    bytes32 public merkleRoot;

    constructor(bytes32 merkleRoot_) {
        merkleRoot = merkleRoot_;
    }

    // Does nothing if caller provides valid merkle proof, otherwise reverts.
    function airdrop(uint256 amount, bytes32[] calldata proof) external {
        // See https://github.com/OpenZeppelin/merkle-tree#treeleafhash.
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(msg.sender, amount))));

        bool ok = MerkleProof.verify({proof: proof, root: merkleRoot, leaf: leaf});

        if (!ok) {
            revert InvalidProof();
        }
    }
}
