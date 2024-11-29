// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.6;

import "@openzeppelin/contracts/utils/Strings.sol";
import "base64-sol/base64.sol";

/// @title NFTSVG
/// @notice Provides a function for generating an SVG associated with a Uniswap NFT
library NFTSVG {
    using Strings for uint256;

    string constant curve1 = 'M1 1C41 41 105 105 145 145';
    string constant curve2 = 'M1 1C33 49 97 113 145 145';
    string constant curve3 = 'M1 1C33 57 89 113 145 145';
    string constant curve4 = 'M1 1C25 65 81 121 145 145';
    string constant curve5 = 'M1 1C17 73 73 129 145 145';
    string constant curve6 = 'M1 1C9 81 65 137 145 145';
    string constant curve7 = 'M1 1C1 89 57.5 145 145 145';
    string constant curve8 = 'M1 1C1 97 49 145 145 145';

    struct SVGParams {
        string quoteToken;
        string baseToken;
        address poolAddress;
        string quoteTokenSymbol;
        string baseTokenSymbol;
        int24 tickLower;
        int24 tickUpper;
        int24 tickSpacing;
        int8 overRange;
        uint256 tokenId;
    }

    function generateSVG(SVGParams memory params) internal pure returns (string memory svg) {
        /*
        address: "0xe8ab59d3bcde16a29912de83a90eb39628cfc163",
        msg: "Forged in SVG for Uniswap in 2021 by 0xe8ab59d3bcde16a29912de83a90eb39628cfc163",
        sig: "0x2df0e99d9cbfec33a705d83f75666d98b22dea7c1af412c584f7d626d83f02875993df740dc87563b9c73378f8462426da572d7989de88079a382ad96c57b68d1b",
        version: "2"
        */
        return
        string(
            abi.encodePacked(
                '<svg width="300" height="459" viewBox="0 0 300 459" fill="none" xmlns="http://www.w3.org/2000/svg"',
                " xmlns:xlink='http://www.w3.org/1999/xlink' font-family=\"'Poppins', sans-serif\">",
                generateSVGDefs(params),
                '<g filter="url(#nft_filter0_i_3004_12494)">',
                generateSVGCardMantle(params.tokenId.toString()),
                generageSvgCurve(params.tickLower, params.tickUpper, params.tickSpacing, params.overRange),
                generateSVGPositionDataAndLocationCurve(
                    params.baseTokenSymbol,
                    params.quoteTokenSymbol,
                    params.tickSpacing,
                    params.tickLower,
                    params.tickUpper
                ),
                '</g></svg>'
            )
        );
    }

    function generateSVGDefs(SVGParams memory params) private pure returns (string memory svg) {
        svg = string(
            abi.encodePacked(
                '<defs><filter id="nft_filter0_i_3004_12494" x="0" y="0" width="301" height="460" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB"><feFlood flood-opacity="0" result="BackgroundImageFix"/><feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>',
                '<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/><feMorphology radius="1" operator="erode" in="SourceAlpha" result="nft_effect1_innerShadow_3004_12494"/><feOffset dx="1" dy="1"/>',
                '<feGaussianBlur stdDeviation="1"/><feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/><feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0.466669 0 0 0 0 1 0 0 0 1 0"/><feBlend mode="normal" in2="shape" result="nft_effect1_innerShadow_3004_12494"/>',
                '</filter><linearGradient id="nft_paint0_linear_3004_12494" x1="75.75" y1="403.5" x2="155.25" y2="-22.5" gradientUnits="userSpaceOnUse"><stop offset="0.02" stop-color="#142DC9"/><stop offset="0.414804" stop-color="#084EA3"/><stop offset="1" stop-color="#202E84"/></linearGradient>',
                '<linearGradient id="paint1_linear_3004_12494" x1="255.5" y1="126.85" x2="233.045" y2="7.00499" gradientUnits="userSpaceOnUse"><stop offset="0.02" stop-color="#0050A4"/><stop offset="1" stop-color="#2DB4E8"/></linearGradient>',
                '<linearGradient id="nft_paint2_linear_3004_12494" x1="216.675" y1="37.8146" x2="252.83" y2="125.025" gradientUnits="userSpaceOnUse"><stop stop-color="#27ABE5"/><stop offset="0.555" stop-color="#48DCF2"/><stop offset="1" stop-color="#2E88FF"/></linearGradient>',
                '<linearGradient id="nft_paint3_linear_3004_12494" x1="156.665" y1="38.8473" x2="251.407" y2="282.534" gradientUnits="userSpaceOnUse"><stop stop-color="white" stop-opacity="0.6"/><stop offset="0.511314" stop-color="white" stop-opacity="0.24"/><stop offset="0.942239" stop-color="#063190" stop-opacity="0"/></linearGradient>',
                '<linearGradient id="nft_paint4_linear_3004_12494" x1="156.634" y1="69.2795" x2="182.429" y2="266.535" gradientUnits="userSpaceOnUse"><stop stop-color="white"/><stop offset="1" stop-color="#39A0F3" stop-opacity="0"/></linearGradient>',
                '<linearGradient id="nft_paint5_linear_3004_12494" x1="12" y1="325.125" x2="294.128" y2="354.766" gradientUnits="userSpaceOnUse"><stop offset="0.00781089" stop-color="white" stop-opacity="0.1"/><stop offset="1" stop-color="white" stop-opacity="0.05"/></linearGradient>',
                '<linearGradient id="nft_paint6_linear_3004_12494" x1="15.6316" y1="315.856" x2="70.0561" y2="504.666" gradientUnits="userSpaceOnUse"><stop stop-color="#6D9DCC" stop-opacity="0.3"/><stop offset="1" stop-color="#6D9DCC" stop-opacity="0.5"/></linearGradient>',
                '<clipPath id="nft_clip0_3004_12494"><rect width="120" height="120" fill="white" transform="translate(168 12)"/></clipPath>',
                '</defs>'
            )
        );
    }

    function generateSVGCardMantle(string memory tokenId) private pure returns (string memory svg) {
        svg = string(
            abi.encodePacked(
                '<rect width="300" height="459" rx="16" fill="url(#nft_paint0_linear_3004_12494)"/>',
                '<text fill="white" xml:space="preserve" style="white-space: pre" font-size="14" font-weight="600" letter-spacing="0.5px"><tspan x="24" y="39.9">ID: ',
                tokenId,
                '</tspan></text>',
                '<g opacity="0.1" clip-path="url(#nft_clip0_3004_12494)">',
                '<path d="M288 72C288 38.8629 261.137 12 228 12C194.863 12 168 38.8629 168 72C168 105.137 194.863 132 228 132C261.137 132 288 105.137 288 72Z" fill="url(#paint1_linear_3004_12494)"/>',
                '<path d="M197.235 20.5096C206.338 15.0624 216.722 12.1271 227.329 12.0031C237.937 11.8792 248.387 14.571 257.614 19.804C266.841 25.0371 274.516 32.624 279.854 41.7909C285.192 50.9579 288.003 ',
                '61.3767 288 71.9846C288 72.8346 288 73.6796 287.95 74.5146C287.95 74.9396 287.905 75.3646 287.88 75.7746C287.693 78.7972 287.276 81.8009 286.63 84.7596C286.555 85.1346 286.475 85.5096 286.385 ',
                '85.8796C286.385 85.9946 286.325 86.1146 286.3 86.2296L286.1 87.0296C285.955 87.5796 285.8 88.1296 285.65 88.6746L285.42 89.4396C285.177 90.2604 284.91 91.0741 284.62 91.8796C284.62 91.9596 ',
                '284.57 92.0396 284.535 92.1196C284.415 92.4696 284.285 92.7896 284.155 93.1546C284.02 93.5246 283.9 93.8246 283.765 94.1596C283.591 94.6133 283.405 95.0618 283.205 95.5046L282.745 ',
                '96.5396C280.411 101.753 277.346 106.607 273.64 110.955C273.39 111.255 273.125 111.55 272.865 111.845L272.33 112.445C269.854 115.156 267.134 117.635 264.205 119.85L263.535 120.33L262.755 ',
                '120.895L261.755 121.565L260.845 122.175L260.645 122.31L259.705 122.91L258.655 123.58L257.595 124.195C257.24 124.4 256.885 124.595 256.52 124.795L255.435 125.365L254.335 125.925L253.225 ',
                '126.45L252.1 126.96C251.723 127.127 251.343 127.289 250.96 127.445L249.81 127.915L249.68 127.965C249.34 128.102 248.997 128.231 248.65 128.35C248.285 128.47 247.885 128.63 247.5 128.765L247.005 ',
                '128.925C246.376 129.131 245.744 129.331 245.11 129.525C243.471 130.026 241.807 130.444 240.125 130.775H240.075C239.115 130.98 238.14 131.155 237.165 131.305L236.875 131.345C235.975 131.475 ',
                '235.065 131.595 234.15 131.695C230.055 132.103 225.93 132.103 221.835 131.695C220.915 131.595 220.01 131.475 219.105 131.345L218.82 131.305C216.981 131.023 215.155 130.656 213.35 130.205C212.505 ',
                '129.995 211.68 129.76 210.865 129.535L209.6 129.145L208.465 128.77C197.66 125.046 188.143 118.314 181.033 109.365C173.924 100.416 169.519 89.6234 168.335 78.2559C167.152 66.8884 169.24 55.4194 ',
                '174.353 45.1982C179.467 34.977 187.393 26.4289 197.2 20.5596L197.235 20.5096ZM198.615 83.3096C205.549 89.1262 214.315 92.305 223.365 92.2846H224.875C225.195 92.2846 225.545 92.2846 225.84 ',
                '92.2346C226.34 92.2896 226.835 92.3196 227.335 92.3196H227.57C230.574 92.3219 233.488 91.2874 235.818 89.3909C238.148 87.4944 239.752 84.8519 240.36 81.9096C240.4 81.7346 240.36 81.7246 240.41 ',
                '81.6396C240.767 79.7619 240.713 77.8292 240.252 75.9743C239.791 74.1194 238.934 72.3863 237.74 70.894C236.545 69.4018 235.042 68.1859 233.333 67.3298C231.624 66.4737 229.75 65.9977 227.84 ',
                '65.9346H227.35C225.615 65.9346 223.895 66.2646 222.29 66.9196C219.935 67.5046 217.635 68.3046 215.42 69.2946C219.338 64.4663 224.286 60.5754 229.902 57.9071C235.518 55.2388 241.66 53.8607 ',
                '247.877 53.8736C254.095 53.8866 260.231 55.2903 265.836 57.9819C271.441 60.6736 276.373 64.585 280.27 69.4296C279.755 58.9065 276.075 48.784 269.711 40.3876C263.347 31.9912 254.596 25.7122 ',
                '244.603 22.3727C234.611 19.0333 223.843 18.789 213.709 21.6719C203.575 24.5548 194.548 30.4305 187.81 38.5296C184.558 46.1651 183.851 54.6447 185.794 62.7132C187.736 70.7818 192.225 ',
                '78.0105 198.595 83.3296L198.615 83.3096Z" fill="url(#nft_paint2_linear_3004_12494)"/>',
                '</g>'
            )
        );
    }

    function generageSvgCurve(
        int24 tickLower,
        int24 tickUpper,
        int24 tickSpacing,
        int8 overRange
    ) private pure returns (string memory svg) {
        string memory fade = overRange == 1 ? '#fade-up' : overRange == - 1 ? '#fade-down' : '#none';
        string memory curve = getCurve(tickLower, tickUpper, tickSpacing);
        svg = string(
        abi.encodePacked(
        '<g mask="url(',
        fade,
        ')"',
        ' style="transform:translate(72px,110px)">'
        '<rect x="-16px" y="-16px" width="180px" height="180px" fill="none" />'
        '<path d="',
        curve,
        '" stroke="rgba(255,255,255,0.1)" stroke-width="32px" fill="none" stroke-linecap="round" />',
        '</g><g mask="url(',
        fade,
        ')"',
        ' style="transform:translate(72px,110px)">',
        '<rect x="-16px" y="-16px" width="180px" height="180px" fill="none" />',
        '<path d="',
        curve,
        '" stroke="rgba(255,255,255,1)" fill="none" stroke-linecap="round" /></g>',
        generateSVGCurveCircle(overRange)
        )
        );
    }

    function getCurve(
        int24 tickLower,
        int24 tickUpper,
        int24 tickSpacing
    ) internal pure returns (string memory curve) {
        int24 tickRange = (tickUpper - tickLower) / tickSpacing;
        if (tickRange <= 4) {
            curve = curve1;
        } else if (tickRange <= 8) {
            curve = curve2;
        } else if (tickRange <= 16) {
            curve = curve3;
        } else if (tickRange <= 32) {
            curve = curve4;
        } else if (tickRange <= 64) {
            curve = curve5;
        } else if (tickRange <= 128) {
            curve = curve6;
        } else if (tickRange <= 256) {
            curve = curve7;
        } else {
            curve = curve8;
        }
    }

    function generateSVGCurveCircle(int8 overRange) internal pure returns (string memory svg) {
        string memory curvex1 = '73';
        string memory curvey1 = '110';
        string memory curvex2 = '217';
        string memory curvey2 = '255';
        if (overRange == 1 || overRange == - 1) {
            svg = string(
                abi.encodePacked(
                    '<circle cx="',
                    overRange == - 1 ? curvex1 : curvex2,
                    'px" cy="',
                    overRange == - 1 ? curvey1 : curvey2,
                    'px" r="2px" fill="white" /><circle cx="',
                    overRange == - 1 ? curvex1 : curvex2,
                    'px" cy="',
                    overRange == - 1 ? curvey1 : curvey2,
                    'px" r="24px" fill="none" stroke="white" />'
                )
            );
        } else {
            svg = string(
                abi.encodePacked(
                    '<circle cx="',
                    curvex1,
                    'px" cy="',
                    curvey1,
                    'px" r="4px" fill="white" />',
                    '<circle cx="',
                    curvex2,
                    'px" cy="',
                    curvey2,
                    'px" r="4px" fill="white" />'
                )
            );
        }
    }

    function generateSVGPositionDataAndLocationCurve(
        string memory baseTokenSymbol,
        string memory quoteTokenSymbol,
        int24 tickSpacing,
        int24 tickLower,
        int24 tickUpper
    ) private pure returns (string memory svg) {
        string memory tickSpacingStr = tickToString(tickSpacing);
        string memory tickLowerStr = tickToString(tickLower);
        string memory tickUpperStr = tickToString(tickUpper);
        uint256 str2length = bytes(tickLowerStr).length + 10;
        uint256 str3length = bytes(tickUpperStr).length + 10;
        svg = string(
            abi.encodePacked(
                '<rect x="12.25" y="317.25" width="275.5" height="129.5" rx="7.75" fill="url(#nft_paint5_linear_3004_12494)"/>',
                '<rect x="12.25" y="317.25" width="275.5" height="129.5" rx="7.75" stroke="url(#nft_paint6_linear_3004_12494)" stroke-width="0.5"/>',
                '<text fill="white" xml:space="preserve" style="white-space: pre" font-size="18" font-weight="600" letter-spacing="0px"><tspan x="28" y="351.3">',
                baseTokenSymbol,
                ' / ',
                quoteTokenSymbol,
                '</tspan></text>',
                '<text fill="white" xml:space="preserve" style="white-space: pre" font-size="14" letter-spacing="0px"><tspan x="28" y="374.9">Tick Spacing: ',
                tickSpacingStr,
                '</tspan></text>',
                '<text x="28" y="404.9" fill="white" xml:space="preserve" style="white-space: pre" font-size="14" letter-spacing="0px"><tspan>Min Tick:   </tspan><tspan font-weight="600">',
                tickLowerStr,
                '</tspan></text>',
                '<text x="28" y="426.9" fill="white" xml:space="preserve" style="white-space: pre" font-size="14" letter-spacing="0px"><tspan>Max Tick:   </tspan><tspan font-weight="600">',
                tickUpperStr,
                '</tspan></text>'
            )
        );
    }

    function tickToString(int24 tick) private pure returns (string memory) {
        string memory sign = '';
        if (tick < 0) {
            tick = tick * - 1;
            sign = '-';
        }
        return string(abi.encodePacked(sign, uint256(tick).toString()));
    }
}
