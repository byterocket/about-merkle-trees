// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {MerkleProofLib} from "solmate/utils/MerkleProofLib.sol";

contract MerkleVerification {
    error InvalidProof();

    bytes32 public immutable merkleRoot;

    constructor(bytes32 merkleRoot_) {
        merkleRoot = merkleRoot_;
    }

    // Does nothing if caller provides valid merkle proof, otherwise reverts.
    function airdrop(uint256 amount, bytes32[] calldata proof) external {
        // See https://github.com/OpenZeppelin/merkle-tree#treeleafhash.
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(msg.sender, amount))));

        bool ok = MerkleProofLib.verify({proof: proof, root: merkleRoot, leaf: leaf});

        if (!ok) {
            revert InvalidProof();
        }
    }

    /**
    // Note that it's required to compute the leaf outside the verification
    // contract for this attack to work.
    function secondPreimageAttack(bytes32 leaf, bytes32[] calldata proof) external {
        bool ok = MerkleProofLib.verify({proof: proof, root: merkleRoot, leaf: leaf});

        if (!ok) {
            revert InvalidProof();
        }
    }
     */
}
