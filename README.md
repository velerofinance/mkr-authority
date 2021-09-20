# vdgt-authority
Custom authority for allowing VDGT to govern VDGT.

Intentionally simple. Once set as the VDGT token's authority, if the VDGT token's `owner` field is subsequently set to
zero, the following properties obtain:
* any user may call VDGT's `burn` function
* only authorized users (according to the VdgtAuthority's `ward`s) can call VDGT's `mint()` function
* only the `root` user set in the authority can call other `auth`-protected functions of the VDGT contract
* only the `root` user can modify the VdgtAuthority's `ward`s or change the `root`

Though this contract could be used in different ways, it was designed in the context of an overall design for control 
of the VDGT token via VDGT governance as illustrated below.

```
<~~~ : points to source's authority
<=== : points to source's root or owner

-------    -------    ------------    --------------    -----
|Chief|<~~~|Pause|<===|PauseProxy|<===|VdgtAuthority|<~~~|VDGT|===>0
-------    -------    ------------    --------------    -----
```

Such a structure allows governance proposals voted in on the Chief to make arbtirary changes to the VDGT token
and its permissions subject to a delay. (See DappHub contracts
[DSChief](https://github.com/dapphub/ds-chief) and [DSPause](https://github.com/dapphub/ds-pause)
for implementations of the voting contract and the delay contract, respectively.)

Note that the VdgtAuthority allows for upgrading of the VDGT token's `authority` or `owner` by the `root`.

K specifications of the contract's functionality can be found in: https://github.com/velerofinance/k-vdgt-authority/
