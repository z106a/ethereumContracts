const path = require('path');
const fs = require('fs');
const solc = require('solc');

const contractPath = path.resolve(__dirname, 'Contracts', 'Inbox.sol');
const source = fs.readFileSync(contractPath, 'utf8');

console.log(solc.compile(source, 1));