function Navbar(props) {
    return (
        <div>
        <nav className="navbar mt-4 mb-4">
        <div className="container">
            <div className="navbar-brand">
            <h1>Blockchain Gifting Platform</h1>
            </div>
            <div className="navbar-end">
            <button
                onClick={props.onButtonClick}
                id="connectButton"
                className="button is-primary"
            >
                Connect Wallet
            </button>
            <div
                id="connectAddress"
                className="container has-text-info"
                style={{ display: "none" }}
            >
                <p>
                Connected to {props.address.substring(0, 5)}..{props.address.substring(38)}!
                </p>
            </div>
            </div>
        </div>
        </nav>
        <div className="container has-text-danger">
        <p>{props.connectWalletError}</p>
        </div>
        </div>
    );
}

export default Navbar;