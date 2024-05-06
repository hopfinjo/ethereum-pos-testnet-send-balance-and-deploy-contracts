# ethereum-pos-testnet-send-balance-and-deploy-contracts
This projects builds on rzmahmood's "ethereum-pos-testnet" repository. I adapted the code to allocate ether to the accounts and be able to send transactions within the testnet.
Please follow following steps to expand the testnet, so that you can allocate ether to the created accounts, and send transactions from within the geth js terminals.
My scripts unlock each account when creating them. This is not a good security practice and is not advised for real world networks.
Notes: I ran this on a Windows Machine in an Ubuntu app. Ensure that all correct versions are installed. 

## follow @rzmahmoods tutorial how to run and setup an ethereum pos testnet
The repository can be accessed here: https://github.com/rzmahmood/ethereum-pos-testnet?tab=readme-ov-file

## Add create_accounts.sh and start_network_without_acc.sh files
Download the two files "create_account.sh" & "start_network_without_acc.sh" from this repository and add them to your ethereum-pos folder.

## run the code:
* Run the create_accounts.sh file. This will create the accounts only and show you the account addresses in the terminal. Note these account addresses. Sudo is used to avoid permission issues.

      sudo ./create_accounts.sh

![image](https://github.com/hopfinjo/ethereum-pos-testnet-send-balance-and-deploy-contracts/assets/76743011/c4b4b32e-6c6b-4449-9df1-044a5437cb2c)

The password used is "1234". You do not need this anywhere.

*  Add created accounts to the genesis alloc section. This will give the accounts eth, so that you can make transactions with them.
  Ensure high number for allocated per account. Number is in hex in json file.

    sudo nano ./genesis.json

![image](https://github.com/hopfinjo/ethereum-pos-testnet-send-balance-and-deploy-contracts/assets/76743011/605e6f13-1853-4629-b7d3-c16a39892dd4)

Change the two account addresses to the two account addresses created in step1.

* Create account_address.txt file

  Go to network/node-i/ folder. Replace i with 0-ith number of nodes you created. Create file and copy node address seen in step 1, into file.

      sudo nano account_address.txt

  ![image](https://github.com/hopfinjo/ethereum-pos-testnet-send-balance-and-deploy-contracts/assets/76743011/6241c3da-d7bc-4e3c-9809-ba86aa5d8096)


* Start network:

    sudo ./start_network_without_acc.sh


This will start the network.


* Now you will be able to attach a geth terminal to the network:

    sudo geth attach network/node-0/execution/geth.ipc

In this terminal you can do things like: eth.getBalance(eth.accounts[0]) to see acc amount.

* Send ether:

  eth.sendTransaction({from:'0x25e459058DEcbfC44383f78F15eAD5A85489BabA', to:'0xC7C180FaCFB3926576824365833615409cc29284', value: web3.toWei(0.05, "ether"), gas:21001});
  Another more secure way would be to use:
  cast send -r localhost:8000 --private-key $PKEY 0x8D512169343cc6e108a8bB6ec5bc116C416eFc8E --value 0.01ether
  This was not working in my machine, therefore I unlocked the accounts completely and used the above approach.

* Deploy a contract:
Follow tutorial on: https://geth.ethereum.org/docs/interacting-with-geth/javascript-console-contracts



  
  


