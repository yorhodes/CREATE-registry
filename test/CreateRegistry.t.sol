// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CreateRegistry} from "../src/CreateRegistry.sol";

contract CreateRegistryTest is Test {
    CreateRegistry public registry;

    function setUp() public {
        vm.createSelectFork("https://eth.llamarpc.com");
        registry = new CreateRegistry();
    }

    function test_verify_hyperlane() public {
        // $ cast to-rlp '["0xa7eccdb9be08178f896c26b7bbd8c3d4e844d9ba","0x00000000000006a9"]'
        bytes memory rlp = hex"d894a7eccdb9be08178f896c26b7bbd8c3d4e844d9ba8206a9";
        address deployed = 0xc005dc82818d67AF737725bD4bf75435d065D239;
        registry.verify(deployed, rlp);
        assert(registry.deployers(deployed) == 0xa7ECcdb9Be08178f896c26b7BbD8C3D4E844d9Ba);
    }

    function test_verify(address deployer, address deployed, bytes calldata rlpBytes) public {
        vm.expectRevert();
        registry.verify(deployed, rlpBytes);
        assert(registry.deployers(deployed) != address(deployer));
    }
}
