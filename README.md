# Merkle Trees


## Problem Definition

[Ralph Merkle](https://en.wikipedia.org/wiki/Ralph_Merkle) had the solve the following problem for his [1979 phd thesis](https://www.ralphmerkle.com/papers/Thesis1979.pdf):

```
Given a vector of data items = Y1,.  Y2, ... Yn design an algorithm which
can quickly authenticate a randomly chosen Y but which has modest memory
requirements, i.e., does not. have a table of Y1, Y2, ... Yn.
```
_(see page 47)_

(Note: `authenticate` -> proof that item is in vector)

He came up with a _Tree Authentication_ mechanism with which `only log2 n transmissions are required` _(see page 51)_

Remember: Binary tree with `n` elements has height of `log2 n`.


## The Merkle Tree

A _Merkle Tree_ is a tree in which every "leaf" (node) is labelled with the cryptographic hash [= no collision] of a data block, and every node that is not a leaf is labelled with the cryptographic hash of the labels of its child nodes. (see [Wikipedia](https://en.wikipedia.org/wiki/Merkle_tree))

![MerkleTree](./images/Hash_Tree.svg.png)


## Use Case Examples

- Google's [Certificate Transparency Project](https://certificate.transparency.dev/)
    - TLS Certificates (-> public keys binded to a domain) are being issued by [Certificate Authorities](https://en.wikipedia.org/wiki/Certificate_authority)
    - Q: How do you know that the certificate is really the one from the domain?
        - Can not -> Man-in-the-middle possible
        - [TOFU](https://en.wikipedia.org/wiki/Trust_on_first_use) principle => **T**rust **o**n **f**irst **u**se
            - See SSH protocol: `"unknown host, trust certificate? [y,n]"`
        - After first use, certificate can be cached
            - Afterwards, Man-in-the-middle would be noted
    - A: Build a **public**, **append-only** log of certificates
        - Can be read by apps (e.g. browser) to build trust that certificate is actually from the domain

- Golang's [Checksum Database](https://go.dev/ref/mod#checksum-database)
    - Go programs can have external dependencies (e.g. code on github)
    - Q: How can you have **verifiable**, **reproducible** builds when downloading code from the internet?
    - A: Build a **public**, **append-only** log of hashes of go packages (called modules)
        - Compiler:
            1. Download packages from (e.g.) github.com
            2. Compute hash of package
            3. Compare hash of package with public logged hash of package
            4. If unequal -> Code was modified!
        - "This ensures that unexpected code changes cannot be introduced when first adding a dependency to a module or when upgrading a dependency." (see [initial proposal](https://go.googlesource.com/proposal/+/master/design/25530-sumdb.md#checksum-database))
            - Note: "when **first** adding" -> Don't TOFU!
            - After first download: Cache yourself locally

- Token Airdrop
    - A supply of tokens should be airdrop to a set of addresses
    - Q: How can I prove that my address of part of the set?
    - A:
        1. Post the _merkle root_ on-chain
        2. Make the merkle tree publicly available
        3. User can submit _proof_ that their address is part of the tree leading to the merkle root
    - As on-chain verification costs a lot of gas (~money), want to have low memory requirements
        - `Proof size for set of N addresses = log2 N`


## Merkle Proof

![Proof](.images/proof.png)


## Lets make an Airdrop

Using OpenZeppelin's new [merkle-tree](https://github.com/OpenZeppelin/merkle-tree) js library.

See directory `aidrop/`.


## On-chain Verification

See directories `verification-oz/` and `verification-solmate`.

## Attacks

Second pre-image attack -> Not relevant in most practical cases
