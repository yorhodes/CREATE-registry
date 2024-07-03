// SPDX-License-Identifier: Apache-2.0

import "lib/Solidity-RLP/contracts/RLPReader.sol";

contract CreateRegistry {
    using RLPReader for bytes;
    using RLPReader for RLPReader.RLPItem;

    mapping(address => address) public deployers;

    /**
     * @dev CREATE opcode https://www.evm.codes/#f0
     * @param createRlpBytes rlp([sender_address,sender_nonce])
     */
    function verify(bytes calldata createRlpBytes) external {
        address derived = address(uint160(uint256(keccak256(createRlpBytes))));
        require(derived.codehash != bytes32(0x0), "no bytecode at derived");

        RLPReader.RLPItem[] memory items = createRlpBytes.toRlpItem().toList();
        address sender = items[0].toAddress();
        deployers[derived] = sender;
    }
}
