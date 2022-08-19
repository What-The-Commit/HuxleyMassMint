// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Script.sol";
import "../src/MassMint.sol";
import "../src/interfaces/IGenesisToken.sol";
import {Solenv} from "../lib/solenv/src/Solenv.sol";

contract MassMintScript is Script {
    function setUp() public {
        Solenv.config();
    }

    function run() public {
        vm.startBroadcast();
        IGenesisToken genesisToken = IGenesisToken(vm.envAddress("GENESIS_TOKEN_ADDRESS"));
        MassMint massMinter = new MassMint(vm.envAddress("GENESIS_TOKEN_ADDRESS"), vm.envAddress("HUMANS_TOKEN_ADDRESS"));
        genesisToken.setApprovalForAll(address(massMinter), true);
        vm.stopBroadcast();
    }
}
