// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/MerkleVerification.sol";

contract MerkleVerificationTest is Test {
    MerkleVerification merkler;

    bytes32 root = bytes32(0x1b25d2cb5a1a9f97f089095254200530b78f4a61b31696a5ffa7765800c1f3a1);

    // Copied from SuT.
    error InvalidProof();

    function setUp() public {
        merkler = new MerkleVerification(root);
    }

    function testValidProof() public {
        bytes32[] memory proof = new bytes32[](1);
        proof[0] = bytes32(0xf7047704dc588cddb71fadf15815d36e8d89f50f6ec02db755cc74bb8ecf269b);

        vm.prank(address(0xCAFE000000000000000000000000000000000000));
        merkler.airdrop(5000000000000000000, proof);
    }

    function testInvalidProof() public {
        bytes32[] memory proof = new bytes32[](1);
        proof[0] = bytes32(0xf7047704dc588cddb71fadf15815d36e8d89f50f6ec02db755cc74bb8ecf269b);

        vm.prank(address(0xCAFE000000000000000000000000000000000000));

        vm.expectRevert(InvalidProof.selector);
        merkler.airdrop(6000000000000000000, proof);
        //              ^ Changed number of tokens.
    }
}
