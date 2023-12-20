// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IPool } from "@aave/core-v3/contracts/interfaces/IPool.sol";
import { IRewardsController } from "@aave/periphery-v3/contracts/rewards/interfaces/IRewardsController.sol";

contract AAVEIntegration {
    IPool public aave;
    IRewardsController public rewards;

    constructor(address aaveAddress, address rewardsAddress) {
        aave = IPool(aaveAddress);
        rewards = IRewardsController(rewardsAddress);
    }

    function deposit(address token, address user, uint256 amount) external {
        aave.supply(token, amount, user, 0);
    }

    function withdraw(address token, uint256 amount, address to) external {
        aave.withdraw(token, amount, to);
    }

    function getCollateralBalance(address account) external view returns (uint256) {
        (uint256 collateralBase, , , , , ) = aave.getUserAccountData(account);
        return collateralBase;
    }

    function getBorrowBalance(address account) external view returns (uint256) {
        (, uint256 stableDebt, uint256 variableDebt, , , ) = aave.getUserAccountData(account);
        return stableDebt + variableDebt;
    }

    function getRewardsBalance(address[] calldata assets, 
        address user,
        address reward) external view returns (uint256) {
        return rewards.getUserRewards(assets, user, reward);
    }

    function claimRewards(address[] calldata assets, address user, address to) external {
        rewards.claimAllRewardsOnBehalf(assets, user, to);
    }
}
