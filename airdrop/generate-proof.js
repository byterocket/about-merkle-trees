/**
 * Example script to generate a Merkle Proof for each entry.
 * See https://github.com/OpenZeppelin/merkle-tree#obtaining-a-proof
 *
 * Usage:
 *      node generate-proof.js
 */
import { StandardMerkleTree } from "@openzeppelin/merkle-tree";
import fs from "fs";

// Load the tree from the description that was generated previously.
const tree = StandardMerkleTree.load(JSON.parse(fs.readFileSync("tree.json")));

// Loop through the entries.
for (const [i, v] of tree.entries()) {
    // Generate the proof.
    const proof = tree.getProof(i);

    console.log('Value:', v);
    console.log('Proof:', proof);
}
