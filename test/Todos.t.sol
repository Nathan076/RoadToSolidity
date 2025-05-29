// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Todos} from "../src/Todos.sol";

contract TodosTest is Test {
    Todos todos;

    function setUp() public {
        todos = new Todos();
    }

    function testAddPerson() public {
        todos.addPerson("Alice", 42);

        (string memory _name, uint256 _shoeSize) = todos.getPerson(0);

        assertEq(_name, "Alice");
        assertEq(_shoeSize, 42);
    }

    function testMultiplePeople() public {
        todos.addPerson("Bob", 44);
        todos.addPerson("Carol", 38);

        (string memory name1, uint256 size1) = todos.getPerson(0);
        (string memory name2, uint256 size2) = todos.getPerson(1);

        assertEq(name1, "Bob");
        assertEq(size1, 44);
        assertEq(name2, "Carol");
        assertEq(size2, 38);
    }
}
  
