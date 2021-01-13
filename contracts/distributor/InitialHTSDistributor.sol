pragma solidity ^0.6.0;

import '@openzeppelin/contracts/math/SafeMath.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

import '../interfaces/IDistributor.sol';
import '../interfaces/IRewardDistributionRecipient.sol';

contract InitialHTSDistributor is IDistributor {
    using SafeMath for uint256;

    event Distributed(address pool, uint256 cashAmount);

    bool public once = true;

    IERC20 public share;
    IRewardDistributionRecipient public htchtLPPool;
    uint256 public htchtInitialBalance;
    IRewardDistributionRecipient public htshtLPPool;
    uint256 public htshtInitialBalance;

    IRewardDistributionRecipient public htchusdLPPool;
    uint256 public htchusdInitialBalance;
    IRewardDistributionRecipient public htshusdLPPool;
    uint256 public htshusdInitialBalance;

    constructor(
        IERC20 _share,

        IRewardDistributionRecipient _htchtLPPool,
        uint256 _htchtInitialBalance,
        IRewardDistributionRecipient _htshtLPPool,
        uint256 _htshtInitialBalance,

        IRewardDistributionRecipient _htchusdLPPool,
        uint256 _htchusdInitialBalance,
        IRewardDistributionRecipient _htshusdLPPool,
        uint256 _htshusdInitialBalance
    ) public {
        share = _share;

        htchtLPPool = _htchtLPPool;
        htchtInitialBalance = _htchtInitialBalance;
        htshtLPPool = _htshtLPPool;
        htshtInitialBalance = _htshtInitialBalance;

        htchusdLPPool = _htchusdLPPool;
        htchusdInitialBalance = _htchusdInitialBalance;
        htshusdLPPool = _htshusdLPPool;
        htshusdInitialBalance = _htshusdInitialBalance;
    }

    function distribute() public override {
        require(
            once,
            'InitialShareDistributor: you cannot run this function twice'
        );
        // 75%
        uint256 oneTotal01 = htchtInitialBalance.mul(5).div(100);
        share.transfer(address(htchtLPPool), htchtInitialBalance.add(oneTotal01));
        htchtLPPool.notifyRewardAmount(htchtInitialBalance);
        emit Distributed(address(htchtLPPool), htchtInitialBalance);
        
        uint256 oneTotal02 = htshtInitialBalance.mul(5).div(100);
        share.transfer(address(htshtLPPool), htshtInitialBalance.add(oneTotal02));
        htshtLPPool.notifyRewardAmount(htshtInitialBalance);
        emit Distributed(address(htshtLPPool), htshtInitialBalance);

        //25%
        uint256 towTotal01 = htchusdInitialBalance.mul(5).div(100);
        share.transfer(address(htchusdLPPool), htchusdInitialBalance.add(towTotal01));
        htchusdLPPool.notifyRewardAmount(htchusdInitialBalance);
        emit Distributed(address(htchusdLPPool), htchusdInitialBalance);

        uint256 towTotal02 = htshusdInitialBalance.mul(5).div(100);
        share.transfer(address(htshusdLPPool), htshusdInitialBalance.add(towTotal02));
        htshusdLPPool.notifyRewardAmount(htshusdInitialBalance);
        emit Distributed(address(htshusdLPPool), htshusdInitialBalance);

        once = false;
    }
}