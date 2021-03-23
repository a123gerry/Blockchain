pragma solidity ^0.6.0;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'DistributorRole' to manage this role - add, remove, check
contract ProcessingfactoryRole {

  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event ProcessingfactoryAdded(address indexed account);
  event ProcessingfactoryRemoved(address indexed account);

  // Define a struct 'processingfactorys' by inheriting from 'Roles' library, struct Role
  Roles.Role private processingfactories;

  // In the constructor make the address that deploys this contract the 1st processingfactory
  constructor() public {
    // The first processingfactory will be the person deploying this contract
    _addProcessingfactory(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyProcessingfactory() {
      require(processingfactories.has(msg.sender), "This account has no Processingfactory Role");
    _;
  }

  // Define a function 'isProcessingfactory' to check this role
  function isProcessingfactory(address account) public view returns (bool) {
       return processingfactories.has(account);
  }

  // Define a function 'addProcessingfactory' that adds this role
  function addProcessingfactory(address account) public onlyProcessingfactory {
      _addProcessingfactory(account);
  }

  // Define a function 'renounceProcessingfactory' to renounce this role
  function renounceProcessingfactory() public {
    _removeProcessingfactory(msg.sender);
  }

  // Define an internal function '_addProcessingfactory' to add this role, called by 'addProcessingfactory'
  function _addProcessingfactory(address account) internal {
    processingfactories.add(account);
    emit ProcessingfactoryAdded(account);
  }

  // Define an internal function '_removeProcessingfactory' to remove this role, called by 'removeProcessingfactory'
  function _removeProcessingfactory(address account) internal {
    processingfactories.remove(account);
    emit ProcessingfactoryRemoved(account);
  }
}