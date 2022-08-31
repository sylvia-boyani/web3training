pragma solidity 0.8.9;

contract BankApp {
    string name;
    address public manager;
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
        name = _name;
    }

    function register(
        address user,
        uint256 id,
        string memory name,
        string memory kraPin,
        uint256 balance,
        uint256 amount
    ) public returns (bool) {
        require(msg.sender == manager, "sender not manager");

        Account memory account = accounts[user];
        //check if the account is created
        if (account.id != 0) {
            revert("Account already exists");

            account.id = id;
            account.name = name;
            account.kraPin = kraPin;
            account.balance = balance;

            accounts[user] = account;

            return true;
        }
    }

    function login() public returns (bool) {
        address _user = msg.sender;
        Account memory account = accounts[_user];

        if (account.id == 0) {
            revert("Account does not exists");
        }

        if (account.status) {
            return true;
        }

        account.status = true;
    }

    function deposit(uint256 amount) public isLoggedIn(msg.sender) {
        Account memory account = accounts[msg.sender];
        account.balance += amount;

        accounts[msg.sender] = account;
    }

    function balanceOf(address _user)
        public
        view
        isLoggedIn(_user)
        returns (uint256)
    {
        Account memory account = accounts[_user];
        return account.balance;
    }
}
