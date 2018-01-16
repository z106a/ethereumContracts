pragma solidity ^0.4.17;

contract Lottery {
    address public manager;

    address[] public players;

    function Lottery() public { // init constructor
        manager = msg.sender; // global variable msg.sender. who created a contract
    }

    modifier restricted() {
        require(msg.sender == manager); // require executer be a manager who created a contract
        _;
    }

    function getPlayers() public view returns(address[]) { // all players in array helper func
        return players;
    }

    function enter() public payable { // enter a game, require payable
        require(msg.value > .01 ether); // min ammount to enter

        players.push(msg.sender);
    }

    function random() private view returns (uint){
        return uint(keccak256(block.difficulty, now, players));
    }

    function pickWinner() public restricted{
        uint index = random() % players.length; // select pseudo-randomly a winner player
        players[index].transfer(this.balance); // send all money to winner
        players = new address[](0); // clear array of players
    }
}