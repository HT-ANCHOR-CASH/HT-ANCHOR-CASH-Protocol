pragma solidity ^0.6.0;

import '../distribution/ERC20Pool.sol';
import '../distribution/HTPool.sol';
import '../interfaces/IDistributor.sol';

contract InitialHTCDistributor is IDistributor {
    using SafeMath for uint256;

    event Distributed(address pool, uint256 HTCAmount);

    bool public once = true;

    IERC20 public HTC;
    IRewardDistributionRecipient[] public pools;
    uint256 public totalInitialBalance;

    constructor(
        IERC20 _htc,
        IRewardDistributionRecipient[] memory _pools,
        uint256 _totalInitialBalance
    ) public {
        require(_pools.length != 0, 'a list of BAC pools are required');
        HTC = _htc;
        pools = _pools;
        totalInitialBalance = _totalInitialBalance;
    }

    function distribute() public override {
        require(
            once,
            'InitialHTCDistributor: you cannot run this function twice'
        );

        for (uint256 i = 0; i < pools.length; i++) {
            uint256 amount = totalInitialBalance.div(pools.length);

            HTC.transfer(address(pools[i]), amount);
            pools[i].notifyRewardAmount(amount);

            emit Distributed(address(pools[i]), amount);
        }

        once = false;
    }
}
