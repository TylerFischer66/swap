pragma solidity ^0.6.6;

import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IERC20.sol";
import "@uniswap/v2-periphery/contracts/libraries/UniswapV2Library.sol";

contract BasicSwap {
    address public factory;
    IUniswapV2Router02 public router;
    event logAddress(address oy);
    event aogAddress(address oy);
    event log(string oy);
    event logNum(uint256 oy);

    constructor(address _factory, address _router) public {
        factory = _factory;
        router = IUniswapV2Router02(_router);
    }

    function balanceOf(IERC20 token) external view returns (uint256 balance) {
        balance = token.balanceOf(address(this));
    }

    function pairInfo(address tokenA, address tokenB)
        external
        view
        returns (
            uint256 reserveA,
            uint256 reserveB,
            uint256 totalSupply
        )
    {
        IUniswapV2Pair pair = IUniswapV2Pair(
            UniswapV2Library.pairFor(factory, tokenA, tokenB)
        );
        totalSupply = pair.totalSupply();
        (uint256 reserves0, uint256 reserves1, ) = pair.getReserves();
        (reserveA, reserveB) = tokenA == pair.token0()
            ? (reserves0, reserves1)
            : (reserves1, reserves0);
    }

    function tokenInfo(IERC20 token)
        external
        view
        returns (
            string memory name,
            string memory symbol,
            uint256 allowance
        )
    {
        name = token.name();
        symbol = token.symbol();
        allowance = token.allowance(msg.sender, address(this));
    }

    function swap(
        IERC20 tokenToBeSent,
        // IERC20 tokenB,
        uint256 tokenToBeSentAmount
    ) external {
        //first get the tokens from msg.sender
        emit logNum(tokenToBeSentAmount);
        require(tokenToBeSentAmount > 0, "amount needs to be greater than 0");
        require(
            tokenToBeSent.allowance(msg.sender, address(this)) >=
                tokenToBeSentAmount,
            "need approval for token amount"
        );
        require(
            tokenToBeSent.transferFrom(
                msg.sender,
                address(this),
                tokenToBeSentAmount
            ),
            "transferFrom failed. do you need to approve it first?"
        );
        emit log("transfer to contract successful");
    }

}
