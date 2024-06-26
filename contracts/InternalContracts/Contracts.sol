// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./AdminControl.sol";
import "./MazzeContext.sol";
import "./Contracts.sol";
import "./CrossSpaceCall.sol";
import "./ParamsControl.sol";
import "./PoSRegister.sol";
import "./SponsorWhitelistControl.sol";
import "./Staking.sol";


contract InternalContracts {
    AdminControl constant adminControl = AdminControl(0x0888000000000000000000000000000000000000);
    SponsorWhitelistControl constant sponsorWhitelistControl = SponsorWhitelistControl(0x0888000000000000000000000000000000000001);
    Staking constant stakingControl = Staking(0x0888000000000000000000000000000000000002);
    MazzeContext constant mazzeContext = MazzeContext(0x0888000000000000000000000000000000000004);
    PoSRegister constant posRegister = PoSRegister(0x0888000000000000000000000000000000000005);
    CrossSpaceCall constant crossSpaceCall = CrossSpaceCall(0x0888000000000000000000000000000000000006);
    ParamsControl constant paramsControl = ParamsControl(0x0888000000000000000000000000000000000007);
}