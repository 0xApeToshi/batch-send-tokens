// SPDX-License-Identifier: MIT
// Creator: Ape Toshi

pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BatchSendTokens {
    function batchSendETH(
        address payable[] calldata _addresses,
        uint256[] calldata _amounts
    ) external payable {
        for (uint256 i; i < _addresses.length; i++) {
            _addresses[i].transfer(_amounts[i]);
        }
        require(
            address(this).balance == 0,
            "Total ETH sent doesn't match up ETH received"
        );
    }

    // Needs to be approved
    function batchSendERC20(
        address tokenAddress,
        address payable[] calldata _addresses,
        uint256[] calldata _amounts
    ) external {
        IERC20 Itoken = IERC20(tokenAddress);
        for (uint256 i; i < _addresses.length; i++) {
            Itoken.transferFrom(msg.sender, _addresses[i], _amounts[i]);
        }
    }

    receive() external payable {
        revert("Direct sending is not supported");
    }
}
