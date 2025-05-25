// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken token;
    address user1 = address(0x1);
    address user2 = address(0x2);

    function setUp() public {
        token = new MyToken(1000 ether);
        vm.prank(address(this));
        token.transfer(user1, 500 ether);
    }

    function testInitialBalance() public {
        assertEq(token.balanceOf(user1), 500 ether);
        assertEq(token.balanceOf(address(this)), 500 ether);
    }

    function testTransfer() public {
        vm.prank(user1);
        token.transfer(user2, 200 ether);
        assertEq(token.balanceOf(user2), 200 ether);
        assertEq(token.balanceOf(user1), 300 ether);
    }

    function testApproveAndTransferFrom() public {
        vm.prank(user1);
        token.approve(address(this), 100 ether);

        vm.prank(address(this));
        token.transferFrom(user1, user2, 100 ether);

        assertEq(token.balanceOf(user2), 100 ether);
        assertEq(token.balanceOf(user1), 400 ether);
    }
    function testRequire () public {
        vm.prank(user1);
        vm.expectRevert(bytes("Not enough balance"));
        token.transfer(user2, 400 ether);
    }
}