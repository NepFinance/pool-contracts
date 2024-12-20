// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;
pragma abicoder v2;

import "../libraries/NFTDescriptor.sol";
import "../libraries/NFTSVG.sol";

contract NFTDescriptorTest {
    function constructTokenURI(NFTDescriptor.ConstructTokenURIParams calldata params)
        public
        pure
        returns (string memory)
    {
        return NFTDescriptor.constructTokenURI(params);
    }

    function getGasCostOfConstructTokenURI(NFTDescriptor.ConstructTokenURIParams calldata params)
        public
        view
        returns (uint256)
    {
        uint256 gasBefore = gasleft();
        NFTDescriptor.constructTokenURI(params);
        return gasBefore - gasleft();
    }

    function tickToDecimalString(
        int24 tick,
        int24 tickSpacing,
        uint8 token0Decimals,
        uint8 token1Decimals,
        bool flipRatio
    ) public pure returns (string memory) {
        return NFTDescriptor.tickToDecimalString(tick, tickSpacing, token0Decimals, token1Decimals, flipRatio);
    }

    function fixedPointToDecimalString(uint160 sqrtRatioX96, uint8 token0Decimals, uint8 token1Decimals)
        public
        pure
        returns (string memory)
    {
        return NFTDescriptor.fixedPointToDecimalString(sqrtRatioX96, token0Decimals, token1Decimals);
    }

    function addressToString(address _address) public pure returns (string memory) {
        return NFTDescriptor.addressToString(_address);
    }

//    function generateSVGImage(
//        NFTDescriptor.ConstructTokenURIParams memory params,
//        uint256 quoteTokensOwed,
//        uint256 baseTokensOwed
//    ) public pure returns (string memory) {
//        return NFTSVG.generateSVG({
//            quoteTokenSymbol: params.quoteTokenSymbol,
//            baseTokenSymbol: params.baseTokenSymbol,
//            quoteTokensOwed: quoteTokensOwed,
//            baseTokensOwed: baseTokensOwed,
//            tokenId: params.tokenId,
//            tickLower: params.tickLower,
//            tickUpper: params.tickUpper,
//            tickSpacing: params.tickSpacing,
//            quoteTokenDecimals: params.quoteTokenDecimals,
//            baseTokenDecimals: params.baseTokenDecimals
//        });
//    }
}
