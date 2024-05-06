//SPDX-License-Identufuer: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetwork;

    struct NetworkConfig {
        address priceFeed;
    }

    constructor() {
        activeNetwork = getCorrectNetwork();
    }

    function getSepoliaEthConfig() private pure returns (NetworkConfig memory) {
        return
            NetworkConfig({
                priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
            });
    }

    function getMainNetConfig() private pure returns (NetworkConfig memory) {
        return
            NetworkConfig({
                priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
            });
    }

    function getAnvilEthConfig() private returns (NetworkConfig memory) {
        if (activeNetwork.priceFeed != address(0)) {
            return activeNetwork;
        }

        uint8 decimals = 8;
        int256 initialAnswer = 2000e8;

        vm.startBroadcast();
        MockV3Aggregator mockV3Aggregator = new MockV3Aggregator(
            decimals,
            initialAnswer
        );
        vm.stopBroadcast();

        return NetworkConfig({priceFeed: address(mockV3Aggregator)});
    }

    function getCorrectNetwork() private returns (NetworkConfig memory) {
        if (block.chainid == 11155111) {
            return getSepoliaEthConfig();
        } else if (block.chainid == 1) {
            return getMainNetConfig();
        } else {
            return getAnvilEthConfig();
        }
    }
}
