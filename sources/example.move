// module artfi::artfi {
    
//     use std::option;
//     use sui::coin;                          // https://github.com/MystenLabs/sui/blob/main/crates/sui-framework/docs/coin.md
//     use sui::transfer;                      // https://github.com/MystenLabs/sui/blob/main/crates/sui-framework/docs/transfer.md
//     use sui::url::{Self, Url};              // https://github.com/MystenLabs/sui/blob/main/crates/sui-framework/docs/url.md
//     use sui::tx_context::{Self, TxContext}; // https://github.com/MystenLabs/sui/blob/main/crates/sui-framework/docs/tx_context.md

//     /// The type identifier of coin. The coin will have a type tag of kind: 
//     /// `Coin<package_object::artfi::ARTFI>`
//     struct ARTFI has drop {}
    

//     /// Module initializer is called once on module publish. A treasury cap is sent to the 
//     /// publisher, who then controls minting and burning
//     fun init(witness: ARTFI, ctx: &mut TxContext) {
//         // Get a treasury cap for the coin and give it to the transaction sender
//         let (treasury_cap, metadata) = coin::create_currency<ARTFI>(
//             witness, 9, 
//             b"ARTFI", 
//             b"ARTFI", 
//             b"ARTFI is native coin of artfitoken.io", 
//             /*icon_url=*/option::some<Url>(url::new_unsafe_from_bytes(b"https://arweave.net/dG1ec3skYBn7kZ1rWVmiC8QCotv4c7v2FlmQCw4DOgw")), 
//             /*ctx=*/ctx);
//         transfer::public_freeze_object(metadata);
//         coin::mint_and_transfer(&mut treasury_cap, 1000000000000000000, tx_context::sender(ctx), ctx);
//         transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
//     }


// #[test_only]
//     /// Wrapper of module initializer for testing
//     public fun test_init(ctx: &mut TxContext) {
//         init(ARTFI {}, ctx)
//     }
// }