// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Todos{

    struct Todo{
        string name;
        uint256 shoeSize;
    }
    Todo[] public todos;
    function addPerson(string memory _name, uint256 _shoeSize) public{
        todos.push(Todo(_name,_shoeSize));
    }
    function getPerson(uint256 index) public view returns (string memory, uint256) {
        require(index < todos.length, "Index out of bounds");
        Todo storage todo = todos[index];
        return (todo.name, todo.shoeSize);
    }
}
