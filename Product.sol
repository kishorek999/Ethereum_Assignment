pragma solidity ^0.5.1;
contract ProductSmart{
    uint public productCount=0;
    
    event ProductCreated(uint, string, string,string);
    event OwnershipChange(uint id, address indexed newOwner);
    struct Product{
        uint id;
         string name;
         string color;
        string status;
    } 
 address owner;
    mapping(uint => Product[]) public productid;

    Product[] public products;

    modifier isAdmin() {
        require(msg.sender == owner, "you don't have admin access");
        _;
    }

 modifier onlyOwner {
    require(msg.sender == owner) ;
    _;
  }

    constructor() public {
        owner = msg.sender;
        } 
        
   
    function addProduct(uint idx,uint id, string memory name,string memory color, string memory status) isAdmin public payable {

        products.push(Product({
            id: id,
            name : name,
            color:color,
            status : status
        }));
        
        productid[idx].push(Product(id,name,color, status));
        productid[id].push(Product(id,name,color,status));
  productCount ++;       
 
        emit ProductCreated(id, name, color,status);
    }


       function ChangeProductOwner(uint id,address payable _newOwner)  onlyOwner public{
           
            require(_newOwner !=address(0));
          
        owner = _newOwner;
        
        
          emit  OwnershipChange(id,_newOwner);
         
        

    }

function getProductById(uint id,uint idx) public view returns (string memory ,string memory ,string memory) {
    
    Product storage p= productid[id][idx];
  
    return(p.name,p.color,p.status);
}
    
    function getProductCount() external view returns (uint) { 

 
return productCount;

}
   function getOwner() external view returns (address){
       return owner;
   }

      function getPos(uint Position) external view returns (uint,string memory,string memory,string memory) {
    Product storage product = products[Position];
    return (product.id,product.name,product.color,product.status);
}
}

______________________________________________________________________________________________________________________________


pragma solidity ^0.5.11;
contract ProductSmart{
uint256 public productCount=0;

  struct Product{
        uint id;
        
         
         string name;
         address owner;
         string color;
        string status;
    } 
 
mapping(uint=>Product) public productid;
Product[] public products;

event ProductCreated(uint id,string name,string color);
event OwnershipChange(uint id, address indexed newOwner);




function addProduct(uint id,string memory name,address owner,string memory color,string memory status) public payable {
   productid[id]=Product(id,name,owner,color,status);
    products.push(Product({
            id: id,
            name : name,
            owner : owner,
            color:color,
            status : status
        }));
        
    
  productCount ++;

}
function changeProductOwner( uint id,address owner,address newOwner)  public payable{
  
 owner= newOwner;
 emit OwnershipChange(id , newOwner);
}

function getProductById(uint id) public view returns (string memory ,string memory ,string memory) {
    
    Product storage p= productid[id];
  
    return(p.name,p.color,p.status);
}

     function getPos(uint Position) external view returns (uint,string memory,string memory,string memory) {
    Product storage product = products[Position];
    return (product.id,product.name,product.color,product.status);
}
  function getProductCount() external view returns (uint) { 

 
return productCount;

}

}
