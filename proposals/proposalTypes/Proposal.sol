pragma solidity 0.8.19;

import {Test} from "@forge-std/Test.sol";
import {IProposal} from "@proposals/proposalTypes/IProposal.sol";
import {Script} from "@forge-std/Script.sol";
import {Addresses} from "@addresses/Addresses.sol";

abstract contract Proposal is Test, Script, IProposal {
    struct Action {
        address target;
        uint256 value;
        bytes arguments;
        string description;
    }

    Action[] public actions;

    bool internal DEBUG;
    uint256 private PRIVATE_KEY;
    bool private DO_DEPLOY;
    bool private DO_AFTER_DEPLOY;
    bool private DO_AFTER_DEPLOY_SETUP;
    bool private DO_BUILD;
    bool private DO_RUN;
    bool private DO_TEARDOWN;
    bool private DO_VALIDATE;
    bool private DO_PRINT;

    address public executor;

    /// default to automatically setting all environment variables to true
    constructor() {
        PRIVATE_KEY = uint256(vm.envBytes32("DEPLOYER_KEY"));
        DEBUG = vm.envOr("DEBUG", true);
        DO_DEPLOY = vm.envOr("DO_DEPLOY", true);
        DO_AFTER_DEPLOY = vm.envOr("DO_AFTER_DEPLOY", true);
        DO_AFTER_DEPLOY_SETUP = vm.envOr("DO_AFTER_DEPLOY_SETUP", true);
        DO_BUILD = vm.envOr("DO_BUILD", true);
        DO_RUN = vm.envOr("DO_RUN", true);
        DO_TEARDOWN = vm.envOr("DO_TEARDOWN", true);
        DO_VALIDATE = vm.envOr("DO_VALIDATE", true);
        DO_PRINT = vm.envOr("DO_PRINT", true);
    }

    /// @notice set the debug flag
    function setDebug(bool debug) public {
        DEBUG = debug;
    }

    /// @notice push an action to the proposal
    function _pushAction(uint256 value, address target, bytes memory data, string memory description) internal {
        actions.push(Action({value: value, target: target, arguments: data, description: description}));
    }

    /// @notice push an action to the proposal with a value of 0
    function _pushAction(address target, bytes memory data, string memory description) internal {
        _pushAction(0, target, data, description);
    }

    function _pushAction(uint256 value, address target, bytes memory data)  internal {
        _pushAction(value, target, data, "");
    }

    function _pushAction(address target, bytes memory data) internal {
        _pushAction(0, target, data, "");
    }

    function name() virtual external view returns(string memory) {}

    function deploy(Addresses, address) external {}

    function afterDeploy(Addresses, address) external {}

    function afterDeploySetup(Addresses) external {}

    function build(Addresses) external {}

    function run(Addresses, address) external {}

    function teardown(Addresses, address) external {}

    function validate(Addresses, address) external {}

    function printProposalActionSteps() external virtual {}

}
