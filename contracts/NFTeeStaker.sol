// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "hardhat/console.sol";

contract NFTeeStaker is ERC20, ReentrancyGuard {
    IERC721 nftContract;
    uint256 constant SECOND_PER_DAY = 24 * 60 * 60;
    uint256 constant BASE_YIELD_RATE = 1000 ether;

    struct Staker {
        uint256 currYield;
        uint256 rewards;
        uint256 lastCheckPoint;
    }

    mapping(address => Staker) public stakers;
    mapping(uint256 => address) public tokenOwners;

    constructor(
        address _nftContract,
        string memory name,
        string memory symbol
    ) ERC20(name, symbol) {
        nftContract = IERC721(_nftContract);
    }

    function stake(uint256[] memory tokenIds) public {
        Staker storage user = stakers[msg.sender];
        uint256 yield = user.currYield;
        uint256 length = tokenIds.length;

        for (uint256 index = 0; index < length; index++) {
            require(
                nftContract.ownerOf(tokenIds[index]) == msg.sender,
                "NOT_OWNED"
            );

            nftContract.transferFrom(
                msg.sender,
                address(this),
                tokenIds[index]
            );
            tokenOwners[tokenIds[index]] = msg.sender;

            yield += BASE_YIELD_RATE;
        }
        accumulate(msg.sender);
        user.currYield = yield;
    }

    function unstake(uint256[] memory tokenIds) public {
        Staker storage user = stakers[msg.sender];
        uint256 yield = user.currYield;
        uint256 length = tokenIds.length;
        for (uint256 index = 0; index < length; index++) {
            require(
                tokenOwners[tokenIds[index]] == msg.sender,
                "NOT_ORIGINAL_OWNER"
            );
            require(
                nftContract.ownerOf(tokenIds[index]) == address(this),
                "NOT_STAKED!"
            );

            tokenOwners[tokenIds[index]] = address(0);

            if (yield != 0) {
                yield -= BASE_YIELD_RATE;
            }
            nftContract.transferFrom(
                address(this),
                msg.sender,
                tokenIds[index]
            );
        }
        accumulate(msg.sender);
        user.currYield = yield;
    }

    function claim() public nonReentrant {
        Staker storage user = stakers[msg.sender];
        accumulate(msg.sender);
        _mint(msg.sender, user.rewards);
        user.rewards = 0;
    }

    function accumulate(address staker) internal {
        stakers[staker].rewards += getrewards(staker);
        stakers[staker].lastCheckPoint = block.timestamp;
    }

    function getrewards(address staker) public view returns (uint256) {
        Staker memory user = stakers[staker];

        if (user.lastCheckPoint == 0) {
            return 0;
        }
        return
            ((block.timestamp - user.lastCheckPoint) * user.currYield) /
            SECOND_PER_DAY;
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external pure returns (bytes4) {
        return
            bytes4(
                keccak256("onERC721Received(address,address,uint256,bytes)")
            );
    }
}
