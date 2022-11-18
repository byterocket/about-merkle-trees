// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/MerkleVerification.sol";

contract MerkleVerificationTest is Test {
    MerkleVerification merkler;

    bytes32 root = bytes32(0xb8f6c4b58876c963340ad9a494da2d654a8acbee2a845a90815a52f041d75cfd);

    // Copied from SuT.
    error InvalidProof();

    function setUp() public {
        merkler = new MerkleVerification(root);
    }

    function testValidProof() public {
        bytes32[] memory proof = new bytes32[](2);
        proof[0] = bytes32(0x458fae6ac250cc62f43982f82122190d7d13f64119ad08f8b113dc163dc05310);
        proof[1] = bytes32(0x64925f15fb3e9fa9809ddfcaa78d15e900a0beafecc1c319d75fe80b3798d5b6);

        vm.prank(address(0xBEEF));
        merkler.airdrop(25e17, proof);
    }

    function testInvalidProof() public {
        bytes32[] memory proof = new bytes32[](2);
        proof[0] = bytes32(0x458fae6ac250cc62f43982f82122190d7d13f64119ad08f8b113dc163dc05310);
        proof[1] = bytes32(0x54925f15fb3e9fa9809ddfcaa78d15e900a0beafecc1c319d75fe80b3798d5b6);

        vm.prank(address(0xBEEF));

        vm.expectRevert(InvalidProof.selector);
        merkler.airdrop(25e17, proof);
        //              ^ Changed number of tokens.
    }

    function testSecondPreimageAttack() public {
        bytes32 leaf = bytes32(0xcbc3f67f079aa8035ead7c1f408d40dcd4f7be7f467eb800122f6ac309598b99);

        bytes32[] memory proof = new bytes32[](1);
        proof[0] = bytes32(0x64925f15fb3e9fa9809ddfcaa78d15e900a0beafecc1c319d75fe80b3798d5b6);

        merkler.secondPreimageAttack(leaf, proof);
    }
}
