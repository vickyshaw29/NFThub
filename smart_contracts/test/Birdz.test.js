const {assert,expect} =require('chai');
const Birdz = artifacts.require('./Birdz');

//check for chai
require('chai')
    .use(require('chai-as-promised'))
    .should()

contract('Birdz',async(accounts)=>{
    //run this first 
    let contract;
    before(async()=>{
        contract = await Birdz.deployed()
    })
    describe('deployment',()=>{
        it('deploys successfully',async()=>{
            const address=contract.address;
            assert.notEqual(address,'');
            assert.notEqual(address,0x0);
            assert.notEqual(address,null);
            assert.notEqual(address,undefined);
        })
        it('has a name and symbol',async()=>{
            const name=await contract.getName();
            const symbol=await contract.getSymbol();
            assert.equal(name,'Birdz');
            assert.equal(symbol,'BZ');
        })
    })
    describe('mint',async()=>{
        it('creates a new token',async()=>{
            const res=await contract.mint('Birdz00')
            const totalSupply=await contract.totalSupply();
            //success
            assert.equal(totalSupply,1);
            const event=res.logs[0].args;
            // assert.equal(event.tokenId.toNumber(),0,'id is correct');
            assert.equal(event._from,'0x0000000000000000000000000000000000000000','from is correct');
            assert.equal(event._to,accounts[0],'to is correct');
            //failure:cannot mint same token twice
            await contract.mint('Birdz00').should.be.rejected;
        })
    })
    describe('indexing',async()=>{
        it('lists tokens',async()=>{
            //mint 3 more tokens
            await contract.mint('Birdz01');
            await contract.mint('Birdz02');
            await contract.mint('Birdz03');
            const totalSupply=await contract.totalSupply();
            let token;
            let result=[];
            for(var i=0;i<totalSupply;i++){
                token=await contract.birdzCollections(i);
                result.push(token);
            }
            let expected=['Birdz00','Birdz01','Birdz02','Birdz03'];
            assert.equal(result.join(','),expected.join(','));
        })
    })
})