// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {MoodNFT} from "src/MoodNFT.sol";
import {ConstantURI} from "src/ConstantURI.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script, ConstantURI {
    MoodNFT moodNFT;

    function run() external returns (MoodNFT) {
        string memory sadSvg = vm.readFile("./images/sad.svg");
        console.log("SadSvg: ", sadSvg);
        string memory happySvg = vm.readFile("./images/happy.svg");
        console.log("HappySvg: ", happySvg);

        vm.startBroadcast();
        moodNFT = new MoodNFT(svgToImageURI(happySvg), svgToImageURI(sadSvg));
        vm.stopBroadcast();

        return moodNFT;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseURI, svgBase64Encoded));
    }
}
