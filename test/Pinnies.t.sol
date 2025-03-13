// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Test, console} from "forge-std/Test.sol";
import "../src/Pinnies.sol";

contract PinniesTest is Test {
    Pinnies public pinnies;
    address public owner;
    address public user;

    function setUp() public {
        owner = address(1);
        user = address(2);

        vm.startPrank(owner);
        pinnies = new Pinnies();
        vm.stopPrank();
    }

    function testSafeMint() public {
        vm.startPrank(owner);
        uint256 tokenId = pinnies.safeMint(user);
        assertEq(pinnies.ownerOf(tokenId), user);
        assertEq(tokenId, 0);

        uint256 secondTokenId = pinnies.safeMint(user);
        assertEq(pinnies.ownerOf(secondTokenId), user);
        assertEq(secondTokenId, 1);
        vm.stopPrank();
    }

    function testTokenURI() public {
        vm.startPrank(owner);
        uint256 tokenId = pinnies.safeMint(user);
        string memory uri = pinnies.tokenURI(tokenId);
        assertEq(
            uri,
            "ipfs://bafkreibcbcnfk2v57p3e6fmyvukq43r5kb5ydqat2x2ox7yy45to5bzlpe"
        );
        vm.stopPrank();
    }

    function testSupportsInterface() public view {
        // Test ERC721 interface support
        bytes4 erc721InterfaceId = 0x80ac58cd;
        assertTrue(pinnies.supportsInterface(erc721InterfaceId));

        // Test ERC721Metadata interface support
        bytes4 erc721MetadataInterfaceId = 0x5b5e139f;
        assertTrue(pinnies.supportsInterface(erc721MetadataInterfaceId));
    }
}
