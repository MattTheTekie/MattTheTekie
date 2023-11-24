---
title: "Discussing about databases - From Fabio Akita YouTube channels"
---

## B-tree

It's a self-balancing tree data structure. It takes almost the same time to access each node.

## dBase

dBase was one of the first database management systems for microcomputers and the most successful in its day.

It used append-only files, that represented tables, which are called dbf files. You could generate indexes for these files.

The index files used a B-tree structure.

## SQLite

SQLite differs from dBase in the sense that it uses only one file with a B-tree structure. This file represents the whole database instead of just one table.