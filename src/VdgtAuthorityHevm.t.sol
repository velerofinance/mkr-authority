pragma solidity >=0.5.12;

// import "ds-test/test.sol";
// import "./VdgtAuthority.sol";

// import "./VdgtAuthority.sol";
// import "./flop.sol";
// import "./flap.sol";

// interface ERC20 {
//     function setAuthority(address whom) external;
//     function setOwner(address whom) external;
//     function owner() external returns(address);
//     function authority() external returns(address);
//     function balanceOf( address who ) external view returns (uint value);
//     function mint(address usr, uint256 wad) external;
//     function burn(address usr, uint256 wad) external;
//     function burn(uint256 wad) external;
//     function stop() external;
//     function approve(address whom, uint256 wad) external returns (bool);
//     function transfer(address whom, uint256 wad) external returns (bool);
// }

// contract User {
//     ERC20 vdgt;
//     GemPit pit;

//     constructor(ERC20 vdgt_, GemPit pit_) public {
//         vdgt = vdgtr_;
//         pit = pit_;
//     }

//     function doApprove(address whom, uint256 wad) external returns (bool) {
//         vdgt.approve(whom, wad);
//     }

//     function doMint(uint256 wad) external {
//         vdgt.mint(address(this), wad);
//     }

//     function doBurn(uint256 wad) external {
//         vdgt.burn(wad);
//     }

//     function doBurn(address whom, uint256 wad) external {
//         vdgt.burn(whom, wad);
//     }

//     function burnPit() external {
//         pit.burn(address(vdgt));
//     }
// }

// contract GemPit {
//     function burn(address gem) external;
// }

// contract VdgtAuthorityTest is DSTest {
//     // Test with this:
//     // It uses the Multisig as the caller
//     // dapp build
//     // DAPP_TEST_TIMESTAMP=$(seth block latest timestamp) DAPP_TEST_NUMBER=$(seth block latest number) DAPP_TEST_ADDRESS=0x8EE7D9235e01e6B42345120b5d270bdB763624C7 hevm dapp-test --rpc=$ETH_RPC_URL --json-file=out/dapp.sol.json

//     ERC20 vdgt;
//     GemPit pit;
//     User user1;
//     User user2;
//     VdgtAuthority auth;

//     function setUp() public {
//         vdgt = ERC20(0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2);
//         pit = GemPit(0x69076e44a9C70a67D5b79d95795Aba299083c275);
//         user1 = new User(vdgt, pit);
//         user2 = new User(vdgt, pit);

//         auth = new VdgtAuthority();
//         vdgt.setAuthority(address(auth));
//         vdgt.setOwner(address(0));
//     }

//     function testCanChangeAuthority() public {
//         VdgtAuthority newAuth = new VdgtAuthority();
//         vdgt.setAuthority(address(newAuth));
//         assertTrue(VdgtAuthority(vdgt.authority()) == newAuth);
//     }

//     function testCanChangeOwner() public {
//         vdgt.setOwner(msg.sender);
//         assertTrue(vdgt.owner() == msg.sender);
//     }

//     function testCanBurnOwn() public {
//         assertTrue(VdgtAuthority(vdgt.authority()) == auth);

//         assertTrue(vdgt.owner() == address(0));

//         vdgt.transfer(address(user1), 1);
//         user1.doBurn(1);
//     }

//     function testCanBurnFromOwn() public {
//         vdgt.transfer(address(user1), 1);
//         user1.doBurn(address(user1), 1);
//     }

//     function testCanBurnPit() public {
//         assertEq(vdgt.balanceOf(address(user1)), 0);

//         uint256 pitBalance = vdgt.balanceOf(address(pit));
//         assertTrue(pitBalance > 0);

//         user1.burnPit();
//         assertEq(vdgt.balanceOf(address(pit)), 0);
//     }

//     function testFailNoApproveAndBurn() public {
//         vdgt.transfer(address(user1), 1);

//         assertEq(vdgt.balanceOf(address(user1)), 1);
//         assertEq(vdgt.balanceOf(address(user2)), 0);

//         user2.doBurn(address(user1), 1);
//     }

//     function testFailNoMint() public {
//         user1.doMint(1);
//     }

//     function testApproveAndBurn() public {
//         vdgt.transfer(address(user1), 1);

//         assertEq(vdgt.balanceOf(address(user1)), 1);
//         assertEq(vdgt.balanceOf(address(user2)), 0);

//         user1.doApprove(address(user2), 1);
//         user2.doBurn(address(user1), 1);

//         assertEq(vdgt.balanceOf(address(user1)), 0);
//         assertEq(vdgt.balanceOf(address(user2)), 0);
//     }

//     function testFullVdgtAuthTest() public {
//         //update the authority
//         //this works because HEVM allows us to set the caller address
//         vdgt.setAuthority(address(auth));
//         assertTrue(address(vdgt.authority()) == address(auth));
//         vdgt.setOwner(address(0));
//         assertTrue(address(vdgt.owner()) == address(0));

//         //get the balance of this contract for some asserts
//         uint balance = vdgt.balanceOf(address(this));

//         //test that we are allowed to mint
//         vdgt.mint(address(this), 10);
//         assertEq(balance + 10, vdgt.balanceOf(address(this)));

//         //test that we are allowed to burn
//         vdgt.burn(address(this), 1);
//         assertEq(balance + 9, vdgt.balanceOf(address(this)));

//         //create a flopper
//         Flopper flop = new Flopper(address(this), address(vdgt));
//         auth.rely(address(flop));

//         //call flop.kick() and flop.deal() which will in turn test the vdgt.burn() function
//         flop.kick(address(this), 1, 1);
//         flop.deal(1);

//         //create a flapper
//         Flapper flap = new Flapper(address(this), address(vdgt));
//         auth.rely(address(flop));

//         //call flap.kick() and flap.deal() which will in turn test the vdgt.mint() function
//         flap.kick(1, 1);
//         flop.deal(1);
//     }
// }
