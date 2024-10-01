// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNFT} from "script/DeployBasicNFT.s.sol";
import {BasicNFT} from "src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;
    address public MINTER = makeAddr("minter1");
    uint256 public constant STARTING_BALANCE = 10 ether;
    string public constant IPSF =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
        vm.deal(MINTER, STARTING_BALANCE);
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNFT.name();
        // assert(expectedName == actualName);
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(MINTER);
        basicNFT.mintNFT(IPSF);
        assert(1 == basicNFT.balanceOf(MINTER));
        assert(
            keccak256(abi.encodePacked(IPSF)) ==
                keccak256(abi.encodePacked(basicNFT.tokenURI(0)))
        );
    }
}
