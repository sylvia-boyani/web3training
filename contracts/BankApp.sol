pragma solidity 0.8.9;

contract BankApp {
    string myName;
    address public manager;
    event Register (address creator, uint256 accountId, uint256 timestamp);
    event Deposit (address sender, uint256 amount, uint256 timestamp);
    event Transfer (address sender, address receiver, uint256 amount);


    struct Account {
        uint id;
        string name;
        string kraPin;
        uint balance;
        bool status;
    }

    mapping(address => Account) accounts;

    modifier isLoggedIn(address _user) {
        Account memory account = accounts[_user];
        if (!account.status) {
            revert("User is not logged in");
        }
        _;
    }

    constructor(string memory _name) {
        //only run once
        manager = msg.sender;
        myName = _name;
    }

    function register(
        address user,
        uint256 id,
        string memory name,
        string memory kraPin,
        uint256 balance) public returns (bool) {

        require(msg.sender == manager, "sender not manager");

        Account memory account = accounts[user];

        //check if the account is created
        if ( account.id != 0 ) {

            revert("Account already exists");
        }

        account.id = id;
        account.name = name;
        account.kraPin = kraPin;
        account.balance = balance;

        accounts[user] = account;

            // emit the event
        emit Register (msg.sender, id, block.timestamp);

        return true;
    }

    function login() public returns (bool) {
        address _user = msg.sender;
        Account storage account = accounts[_user];

        if (account.id == 0) {
            revert("Account does not exists");
        }

        if (account.status) {
            return true;
        }

        account.status = true;

        return true;
    }

    function deposit(uint256 amount) public isLoggedIn(msg.sender) {

        Account memory account = accounts[msg.sender];
        account.balance += amount;

        accounts[msg.sender] = account;

        emit Deposit(msg.sender, amount, block.timestamp);
    }

    function balanceOf(address _user)
        public
        view
        isLoggedIn(msg.sender)
        returns (uint256)
    {
        Account memory account = accounts[_user];
        return account.balance;
    }

    function transfer(address _to, uint256 amount)public isLoggedIn(msg.sender){

        Account storage account0 = accounts[msg.sender];
        Account storage account1 = accounts[_to];

        require(account0.balance >= amount, "Insufficient balance");
        require(account1.id !=0, "Account does not exist");

        account0.balance -= amount;
        account1.balance += amount;

         //emit event
        emit Transfer(msg.sender, _to, amount);
    }
}
