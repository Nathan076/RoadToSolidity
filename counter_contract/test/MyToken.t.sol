// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken token;
    address user1 = address(0x1);
    address user2 = address(0x2);
    uint8 constant DECIMALS = 18;
    uint256 constant TOTALSUPPLY = 1000000 * (10 ** DECIMALS);

    function setUp() public {
        token = new MyToken(TOTALSUPPLY, "MyToken", "MTK", DECIMALS);

         vm.prank(address(this));
        token.transfer(user1, 500);
    
    }
    function testinitialSupply() public view{
        assertEq(token.name(),"MyToken");
        assertEq(token.symbol(),"MTK");
        assertEq(token.totalSupply(),TOTALSUPPLY);
        assertEq(token.decimals(),DECIMALS);
    }
    


    function testTransfer() public {
        vm.prank(user1);
        token.transfer(user2, 200);
        assertEq(token.balanceOf(user2), 200);
        assertEq(token.balanceOf(user1), 300);
    }

    function testApproveAndTransferFrom() public {
        vm.prank(user1);
        token.approve(address(this), 100);

        vm.prank(address(this));
        token.transferFrom(user1, user2, 100);

        assertEq(token.balanceOf(user2), 100);
        assertEq(token.balanceOf(user1), 400);
    }
    function testRequire () public {
        uint256 amount = 2000000 * (10 ** DECIMALS);

        vm.prank(user1);
        vm.expectRevert(bytes("Not enough balance"));
        token.transfer(user2, amount);
    
    }
    function testMint() public {
        uint256 amount = 5 * (10 ** DECIMALS);
        address Miggz = address(0x22);
        token.mint(Miggz, amount);
        assertEq(token.balanceOf(Miggz), amount);
        assertEq(token.totalSupply(), TOTALSUPPLY + amount);
    }
    function testBurn() public {
        uint256 amount = 5 * (10 ** DECIMALS);
        token.burn(amount);
        assertEq(token.balanceOf(address(this), TOTALSUPPLY - amount));
    }
 }   
