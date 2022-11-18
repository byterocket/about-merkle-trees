# Introduction

## Problem Definition

[Ralph Merkle](https://en.wikipedia.org/wiki/Ralph_Merkle) had the solve the following problem in his [phd thesis](https://www.ralphmerkle.com/papers/Thesis1979.pdf) from 1979:

```
Given a vector of data items = Y1,.  Y2, ... Yn design an algorithm which
can quickly authenticate a randomly chosen Y but which has modest memory
requirements, i.e., does not have a table of Y1, Y2, ... Yn.
```
_(see page 47)_

**Notes**:
- `authenticate` -> proof that item is in vector
- We do not want to have a copy of the elements

## The Merkle Tree

## Definition

A _Merkle Tree_ is a data structure for digitally signing datasets with desire
for fast verification of data consistency.

## Example

Want to have:
- Central party that manages a public, append-only log of data
- Anyone is able to verify the log (no data removed, no data changed)

Merkle Trees offers 3 properties to achieve this:

1. For any specific record `R` in a log of length `N`, we can construct a proof
of length `O(log2 N)` allowing the client to verify that `R` is in the log.

2. For any earlier log observed and remembered by the client, we can construct
a proof of length `O(log2 N)` allowing the client to verify that the earlier log
is a prefix of the current log.

3. An auditor can efficiently iterate over the records in the log.

_(For more info, see [Transparent Logs for Skeptical Clients](https://research.swtch.com/tlog) from [Russ Cox](https://swtch.com/~rsc/))_

## How is this achieved?

A _Merkle Tree_ is a tree in which every leaf [-> _node without child nodes_] is labelled with the
cryptographic hash [_-> no collision_] of a data block, and every node that is not
a leaf is labelled with the cryptographic hash of the labels of its child nodes.
_(see [Wikipedia](https://en.wikipedia.org/wiki/Merkle_tree))_

![MerkleTree](./images/Hash_Tree.svg.png)

[Prev](./README.md)
[Next](./1_UseCaseExamples.md)
