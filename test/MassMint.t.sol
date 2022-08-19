// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "../lib/forge-std/src/Test.sol";
import "../src/MassMint.sol";
import "../src/Huxley/GenesisToken.sol";
import "../src/Huxley/HumansToken.sol";

contract ContractTest is Test {
    MassMint private massMinter;
    GenesisToken private genesisToken;
    HumansToken private humansToken;

    function setUp() public {
        genesisToken = new GenesisToken("", "", "");
        humansToken = new HumansToken(address(genesisToken), address(this));
        massMinter = new MassMint(address(genesisToken), address(humansToken));
        massMinter.transferOwnership(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada);

        genesisToken.grantRole(keccak256("MINTER_ROLE"), address(this));
        genesisToken.grantRole(keccak256("REDEEMER_ROLE"), address(humansToken));
        humansToken.setCanMintUsingGenesis(true);

        genesisToken.mint(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 10, "");
        genesisToken.mint(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 10, "");
        genesisToken.mint(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 8, "");
        genesisToken.mint(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 9, "");
        genesisToken.mint(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 5, "");
        genesisToken.mint(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 6, "");

        vm.prank(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada);
        genesisToken.setApprovalForAll(address(massMinter), true);
    }

    function testDeploy() public {
        massMinter = new MassMint(address(genesisToken), address(humansToken));
    }

    function testMassMint() public {
        vm.startPrank(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada);
        massMinter.massMint();
        vm.stopPrank();

        assertEq(humansToken.balanceOf(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada), 6);
    }

    function testTransferGenesisTokens() public {
        vm.startPrank(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada);
        genesisToken.safeTransferFrom(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, address(massMinter), 10, 2, "");
        genesisToken.safeTransferFrom(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, address(massMinter), 8, 1, "");
        genesisToken.safeTransferFrom(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, address(massMinter), 9, 1, "");
        genesisToken.safeTransferFrom(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, address(massMinter), 5, 1, "");
        genesisToken.safeTransferFrom(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, address(massMinter), 6, 1, "");

        massMinter.transferGenesisTokens(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 10, 2);
        massMinter.transferGenesisTokens(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 8, 1);
        massMinter.transferGenesisTokens(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 9, 1);
        massMinter.transferGenesisTokens(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 5, 1);
        massMinter.transferGenesisTokens(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 6, 1);

        assertEq(genesisToken.balanceOf(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 10), 2);
        assertEq(genesisToken.balanceOf(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 8), 1);
        assertEq(genesisToken.balanceOf(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 9), 1);
        assertEq(genesisToken.balanceOf(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 5), 1);
        assertEq(genesisToken.balanceOf(0xC006562812F7Adf75FA0aDCE5f02C33E070e0ada, 6), 1);
        vm.stopPrank();
    }
}
