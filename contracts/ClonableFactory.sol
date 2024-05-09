// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "@openzeppelin/contracts/proxy/Clones.sol";

contract CloneFactory {
  event Cloned(address indexed origin, address indexed clone);

  function createClone(address template) external {
    address cloneAddress = Clones.clone(template);
    emit Cloned(msg.sender, cloneAddress);
  }
}
