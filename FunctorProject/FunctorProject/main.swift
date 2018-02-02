//
//  main.swift
//  FunctorProject
//
//  Created by JonLily on 1/31/18.
//  Copyright © 2018 jsoft-online. All rights reserved.
//

import Foundation

// First let's set up a couple of different collections
let linkedList = LinkedList.start(2).addToStart(3).addToEnd(4)
let regularArray = [3,2,4]

// Next, define some functions
let isOdd = {$0 % 2 == 1}
let stringIt = { $0 ? "yes" : "no" }

// We have made LinkedList and Array conform to Functor(Tag) so we can now fmap them
// First we need to lift the LinkedList and Array to Construct<ArrayTag,Int> and Construct<LinkedListTag,Int>
// The ^ operator does that magic
// Once we've done our lifted stuff, we .lower (equivalently use the operator ¬) back to the original type

let oddsA1 =   linkedList^.fmap(isOdd).fmap(stringIt).lower
let oddsA2 = regularArray^.fmap(isOdd).fmap(stringIt)¬

print(oddsA1)
print(oddsA2)

