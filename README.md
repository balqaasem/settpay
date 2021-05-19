# SETTPAY
## SettPay - The Official Setheum Wallet
* Setheum's easy to use web3 wallet - [setheum.xyz](https://setheum.xyz)
SettPay is the main app for Setheum's multi-chain & cross-chain asset management. 
Stake, take part in network governance, multi-chain transactions all in one. 
Non-custodial, meaning you hold your private keys not settpay, privacy first! 
Built into Setheum! The Setheum Blockchain was built to serve SettPay which is to serve the global community.

## Our Motivation

### Our Vision - (a snippet of it's core message)

"The best financial system you can imagine. And as a by-product of that, the best of communities with support for the poor, the hungry, the sick and needy, uplifting the less-priviledged, supporting orphans and refugees especially kids and women.
We dream to sponsor research & development in medical fields that could potentially cure serious diseases prominent in minority groups globally like the "Sickle Cell" and other serious genetic disorders especially those prominent in kids and communities in under-developed regions of the world like regions in Africa (where I was born & raised).
This is my dream and Setheum will bear it through the "Setheum Foundation's Setheum Charity Fund" which receives a certain portiuon of network fees and SettMint fees and a designated allocation from the SIF (Setheum Investment Fund) including an Initial allocation from the Initial token allocation. And the Setheum Team vow to allocate a portion of our "Token Sale" raise to the "Setheum Charity Fund" which I run under the "Setheum Foundation" to support humanity as a cause because Setheum is indeed purpose driven. And indeed making the people rich is a side-effect of the good work." 
                     - Muhammad-Jibril B.A. 
       (Founder, CEO, CTO | Setheum Labs | Setheum Foundation | 
    Slixon Technologies | SettPay | Setheum Network | Neom Network)

### Our Mission - (a snippet of it's core message)

"SettPay serves the global community. It doesn't just serve it's initially intended purpose. We needed to invent SettPay, and to do that efficiently and innovatively we needed to invent Setheum. And now we realise the entire world needs SettPay and Setheum is there just and only to serve that purpose. Only to serve "SettPay", the halal market,  and the "Setheum Charity Fund", that's it! Getting rich from it is just a real side-effect, so beware" 
                     - Muhammad-Jibril B.A. 
       (Founder, CEO, CTO | Setheum Labs | Setheum Foundation | 
    Slixon Technologies | SettPay | Setheum Network | Neom Network)

## Introduction

* SettPay is designed to help you unboard the Setheum and web3 ecosystem fast and easy. 

- Friendly UI.
- Available for both IOS and Android.
- Intuitive asset management.
- Offline signature supported.
- Secure local accounts storage.
- Simplified staking & network governance.
- Support for any Substrate-based blockchain network.

On SettPay you get to enjoy the following Setheum only perks:

### Cashdrops: (Just Unique to SettPay & Setheum) 

Users of SettPay can claim cashdrop on every transaction. A cashdrop is literally a cashback bonus allocated to all transactors per block on any currency you spend or trade/transact. Just click "claim", so easy.

### Onboarding Bonuses: (Just Unique to SettPay & Setheum) 

New Users of SettPay can claim onboarding bonuses on their new wallets. An onboarding bonuses is literally a signup bonus (except that no signup is needed) allocated to a limited number of new users of the app. 
No signup is needed, just create or import a wallet, complete a captcha, and Just click "Claim", and you're good to go.. so easy.

### Mint your own native Zero-Interest stablecoins - "SettMint": (Just Unique to SettPay & Setheum) 

Users of SettPay can mint their own native currencies like the Naira or the Yen or the Riyal amongst tens of SettCurrencies on SettPay. Users can also propose to add currencies they like and want to trade or spend. 

SettMint lets users "reserve"/"lock" the SETT stablecoin (like the gold-standard) to mint it's equivalent of a SettCurrency of their choice amongst a variety of currencies. 

No interest is involved and it's fully shari'ah compliant (meaning no hidden fees or interest or any forms of usury). Just a 2% minting fee, and a 1% burning fee.

Just "reserve" SETT, mint your SettCurrency, and you're good to go. When you need to unreserve, just do so by burning the SettCurrency. No debt-like risk or massive volatility involved.. Just a few clicks, so easy.

With this you can spend you country's native cryptocurrency independent of the banks and documentations. Pay online and spend on e-commerce platforms, participate in trading on DeFi and Crypto Exchanges.

Store your assets on the blockchain not on the app. Be in custody of your assets and benefit directly from the inflation of the currencies you spend as you spend them (remember the cashdrops - YES this is where it comes from)

### In-Built DEX (Setheum's Built-in Decentralised Exchanges)

Trade and swap on built-in exchanges on both Setheum Network and Neom Network. Provide liquidity, remove liquidity, claim LP Incentives and specialised SettMint Incentives as an LP (Liquidity Provider) on SettPay.

### Explore Markets on SettPay

Users can explore the cryptocurrency markets on Setheum's SettPay, the de-facto wallet of Setheum on Setheum, built-in as a part of Setheum's core technology. Get access to the ForEx markets by trading your SettCurrencies and holding them with full independence and financial freedom. No bank or broker can hold your assets hostage.

### There is much more on Setheum and SettPay.
CHECKOUT [SETHEUM.XYZ](https://setheum.xyz)

Setheum's easy to use multi-chain web3 wallet

## Getting Started

Dependencies
 - Flutter -stable
 - Dart 

To get started
 1. Clone the repo locally, via git clone https://github.com/SettPay/settpay.git `<optional local path>`.
 2. Install the dependencies by running `flutter pub get`.
 3. In AndroidStudio, run `lib/main.dart` with arguments `--flavor=prod` on Android Devices,
 or just run `lib/main.dart` with no arguments on IOS.
 
## Contribute

This app was built with several repos, developers of other substrate based chain
may create their own plugin and put it into the settpay app:

```
__ SettPay/settpay
    |
    |__ SettPay/settpay_ui
    |    |__ SettPay/settpay_sdk
    |
    |__ sp_polkadot
    |    |__ SettPay/settpay_sdk
    |    |__ SettPay/settpay_ui
    |
    |__ <other plugins (sps)>
    |__ <...>
```

### 1. SettPay/settpay.js
This is a `polkadot-js/api` wrapper which will be built into a single `main.js` file
to run in a hidden webView inside the App. So the App will connect to a substrate node
with `polkadot-js`.

And we wrapped `polkadot-js/keyring` in it, so the App can manage keyPairs.

### 2. SettPay/settpay_sdk
This is a `SettPay/js_api` wrapper dart package, it contains:

 1. Keyring. Managing keyPairs.
 2. SettPaySDK. Connect to remote node and call `polkadot-js/api` methods.
 3. SettPayPlugin. A base plugin class, defined the data and life-circle methods
 which will be used in the App.

A SettPay plugin can get users' keyPairs in the App from Keyring instance.

A SettPay plugin implementation should extend the `SettPayPlugin` class and
define it's own data & life-circle methods.

### 3. SettPay/ui
The common used flutter widgets for `SettPay/settpay`, like:
 - AddressInputForm
 - TxConfirmPage
 - ScanPage
 - ...

### 4. SettPay/sp_xxx
Examples:
 1. [SettPay/sp_polkadot](https://github.com/SettPay/sp_polkadot)

### 5. App state management
We use [https://pub.dev/packages/mobx](https://pub.dev/packages/mobx).
so the directories in a plugin looks like this:
```
__ lib
    |__ pages (the UI)
    |__ store (the MobX store)
    |__ service (the Actions fired by UI to mutate the store)
    |__ ...
```

### 6. Submit your plugin
While your plugin was finished and tested, you may submit an issue in this repo.
We will check into your plugin and add it into the App.

### 7. Plugin update
Submit a update request issue to update your plugin. There are two different kinds of update:
 1. Update the dart package. We will rebuild the App and publish a new release.
 2. Update the js code of your plugin (dart code was not affected). We will rebuild the
  js bundle file and the app will perform a hot-update through settpay-api.


### Translation
SettPay has several language programs on a translation projects on [crowdin.com](https://crowdin.com/) at [SettPay](https://crowdin.com/project/settpay)

Language files in the project are written in `json-like` style:
```dart
final enAccount = {
    'key': 'value',
    'key.another': 'Another value for translation.',
    'key.multiline': 'Multiline text are \n split with symbol \n.',
};

/// This 3 strings above will display in the App like:
// value

// Another value for translation.

// Multiline text are
// split with symbol
// .
```
You need to keep the `'key'` field on the left as it is, and translate the `'value'`
field on the right only. Note that the `\n` symbol split a long string into several lines.

Brought to you by Setheum Labs, Setheum Foundation and Slixon Technologies.

### TODO:
- [ ] Add documentation links and medium links.
- [ ] Add proxy account operations.
- [ ] Support walletConnect.
- [ ] New UI.
- [ ] Add NewRone Network plugin.
- [ ] Add Neom Network plugin.
- [ ] Add Setheum Network plugin.

