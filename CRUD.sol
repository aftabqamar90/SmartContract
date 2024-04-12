// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract CRUD
{
    struct Data
    {
        uint Id;
        string name;
    }

    address private owner;
    mapping(uint=> Data) private DataMapping;
    uint private nextId = 0 ;
    mapping(string => bool) private  IsNameExist;
    
    constructor(){
        owner = msg.sender;
    }

    function CreateData(string memory _name)  public  onlyOwner{
        require(!IsNameExist[_name],"This name is already exist, Please try another name");
        uint Index =nextId +1;
        DataMapping[Index] = Data(Index,_name);
        IsNameExist[_name]=true; 
    }

    function ReadData(uint _id)  public view returns (string memory ) {
        return  DataMapping[_id].name;
    }

    function DeleteData(uint _id)  public onlyOwner {
        delete  DataMapping[_id];
    }

    function UpdateData(uint _id,string memory _name)  public onlyOwner {
        require(DataMapping[_id].Id == _id,"Not Found");
        DataMapping[_id].name = _name;
    }

     modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _; 
    }
    
    // please write a function to get all data
    function getAllData() public view returns (Data[] memory) {
        Data[] memory allData= new Data[](nextId);
        for (uint i=1 ; i < nextId; i++) 
        {
            allData[i] =DataMapping[i];
        }
        return allData;     
    }  
}