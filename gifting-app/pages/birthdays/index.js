
import { useState } from "react";
import Head from "next/head";
import Web3 from "web3";
import giftingContract from "../../blockchain/gifting";
import "bulma/css/bulma.css";
import styles from "../../styles/Gifting.module.css";
import detectEthereumProvider from '@metamask/detect-provider'
import Navbar from "./components";

const Gifting = () => {
    const [web3, setWeb3] = useState(null);
    const [address, setAddress] = useState("");
    const [myContract, setMyContract] = useState(null);
    const [connectWalletError, setConnectWalletError] = useState("");
    
    const connectWalletHandler = async () => {
        /* Check if metamask is installed */
        const provider = await detectEthereumProvider();
        console.log("Entering handler");
        setConnectWalletError("");
        if (provider) {
          try {
            // It is metamask ethereum provider API
            /* Requesting wallet connect */
            await provider.request({ method: "eth_requestAccounts" });
            web3 = new Web3(provider);
            setWeb3(web3);
            
            /* Get accounts List and set address */
            const accounts = await web3.eth.getAccounts();
            setAddress(accounts[0]);

            /* Create local vm copy */
            const vm = giftingContract(web3);
            setMyContract(vm);

            /* Hide connect wallet button and display address */
            document.getElementById("connectButton").style.display = "none";
            document.getElementById("connectAddress").style.display = "block";
            
            console.log("Conection successful to " + address);
          } catch (error) {
            setConnectWalletError("Error", error);
          }
        } else {
            // Metamask not installed
            setConnectWalletError("Please install Metamask");
        }
    };

    return (
        <div className={styles.main}>
        <Head>
            <title>Gifting</title>
            <meta
            name="description"
            content="Send gifts to your favorite people"
            />
            <link rel="icon" href="/favicon.ico" />
        </Head>
        <Navbar address={address} onButtonClick={connectWalletHandler} connectWalletError={connectWalletError}/>
        </div>
    );
}
  
export default Gifting;