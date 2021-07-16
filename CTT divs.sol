
pragma solidity >=0.7.0 <0.9.0;

contract CryptoTradesDiv {
    uint256 rate;
    address CTT;
    address lp;
    constructor (uint256 rate_, address CTT_address, address LP) {
        rate = rate_;
        CTT = CTT_address;
        lp = LP;
    }
    struct owner {
        uint256 bal_owned;
        uint256 age;
    }
    mapping (address => owner) account;
    function claim() public {
        if(account[msg.sender].age < block.number) {
            uint256 amount = block.number - account[msg.sender].age / rate / 100000;
            CTT.call(abi.encodeWithSignature("transferFrom(address, address, uint256", address(this), msg.sender, amount));
            account[msg.sender].age = block.number;
        }
    }
    function deposit(uint256 amount)public {
        lp.call(abi.encodeWithSignature("approve(address, uint256)", msg.sender, amount));
        lp.call(abi.encodeWithSignature("transferFrom(address, address, uint256)", msg.sender, address(this), amount));
        account[msg.sender].bal_owned += amount;
    }
    function add_divs(uint256 amount) public {
        CTT.call(abi.encodeWithSignature("approve(address, uint256)", msg.sender, amount));
        CTT.call(abi.encodeWithSignature("transferFrom(address, address, uint256)", msg.sender, address(this), amount));
    }
}
