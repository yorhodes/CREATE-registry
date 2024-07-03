// SPDX-License-Identifier: Apache-2.0

import "lib/Solidity-RLP/contracts/RLPReader.sol";

contract CreateRegistry {
    using RLPReader for bytes;
    using RLPReader for RLPReader.RLPItem;

    mapping(address => address) public deployers;

    /**
     * @dev CREATE opcode https://www.evm.codes/#f0
     * @param deployed The address of the deployed contract
     * @param createRlpBytes rlp([sender_address,sender_nonce])
     */
    function verify(address deployed, bytes calldata createRlpBytes) external {
        require(deployed.codehash != bytes32(0x0), "no bytecode at deployed");

        address derived = address(uint160(uint256(keccak256(createRlpBytes))));
        require(derived == deployed, "derived address does not match deployed");

        RLPReader.RLPItem[] memory items = createRlpBytes.toRlpItem().toList();
        address sender = items[0].toAddress();
        deployers[deployed] = sender;
    }
}
