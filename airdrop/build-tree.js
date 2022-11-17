/**
 * Example script building a Merkle Tree for a token airdrop.
 * See https://github.com/OpenZeppelin/merkle-tree#building-a-tree.
 *
 * Usage:
 *      node build-tree.js
 *
 * Print Tree:
 *      cat tree.json | python -mjson.tool
 */
import { StandardMerkleTree } from "@openzeppelin/merkle-tree";
import fs from "fs";

// Get the values to include in the tree.
// (Note: Consider reading them from a file.)
const values = [
    ["0x000000000000000000000000000000000000CAFE", "5000000000000000000"],
    //                                              ^ 5e18
    ["0x000000000000000000000000000000000000BEEF", "2500000000000000000"],
    //                                              ^ 25e17
    ["0x000000000000000000000000000000000000DEAD", "5000000000000000000"],
    //                                              ^ 5e18
];

// Build the merkle tree.
// Set the encoding to match the values.
const tree = StandardMerkleTree.of(values, ["address", "uint256"]);

// Print the merkle root.
// You will probably publish this value on chain in a smart contract.
console.log('Merkle Root:', tree.root);

// Write a file that describes the tree.
// You will distribute this to users so they can generate proofs for values in
// the tree.
fs.writeFileSync("tree.json", JSON.stringify(tree.dump()));

// Print visual representation of tree.
console.log(tree.render());
