// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.19;


/// @notice This is a contract that stores addresses for different networks.
/// It allows a project to have a single source of truth to get all the addresses
/// for a given network.
interface IAddresses {
    /// @notice get an address for the current chainId
    function getAddress(string memory name) external view returns (address);

    /// @notice get an address for a specific chainId
    function getAddress(string memory name, uint256 _chainId) external view returns (address);

    /// @notice add an address for the current chainId
    function addAddress(string memory name, address addr) external;

    /// @notice add an address for a specific chainId
    function addAddress(string memory name, uint256 _chainId, address addr) external;

    /// @notice remove recorded addresses
    function resetRecordingAddresses() external;

    /// @notice get recorded addresses from a proposal's deployment
    function getRecordedAddresses() external view returns (string[] memory names, address[] memory addresses);
}
