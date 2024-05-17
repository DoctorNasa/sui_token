module firoll::firoll {
    use std::option;
    use sui::coin::{Self, TreasuryCap, Coin, CoinMetadata};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::url;
    use sui::balance::{Self, Balance};
    use sui::object;

    const IconUrl: vector<u8> = b"https://bafybeiecppfzpgx7xosf7h4a2zistip2d4lawqkwsp2dtp3ucmjpmnb6tq.ipfs.nftstorage.link/";

    /// Shared object used to attach the lockers 
    public struct Registry has key {
        id: UID,
        metadata: CoinMetadata<FIROLL>
    }

    /// Marker struct for the FIROLL coin
    public struct FIROLL has drop {}

    /// Struct representing a lock with start and final dates and balances
    public struct Firoll has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: Balance<FIROLL>
    }

    /// Module initializer called once on module publish
    fun init(witness: FIROLL, ctx: &mut TxContext) {
        let ascii_url = std::ascii::string(IconUrl);
        let icon_url = url::new_unsafe(ascii_url);

        // Declare 'treasury' as mutable
        let (mut treasury, metadata) = coin::create_currency(
            witness, 9, b"PRO", b"FIROLL", b"FiRoll Coin for bet gaming protocol", option::some(icon_url), ctx
        );
        transfer::public_freeze_object(metadata);
        coin::mint_and_transfer(&mut treasury, 1000000000000000000, tx_context::sender(ctx), ctx);

        // Send the treasury capability to the deployer
        transfer::public_transfer(treasury, tx_context::sender(ctx));
    }

    /// Mint and transfer coins to a recipient
    public entry fun mint_and_transfer(
        treasury: &mut coin::TreasuryCap<FIROLL>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury, amount, recipient, ctx);
    }

    /// Destroy the coin `c` and decrease the total supply in `cap` accordingly
    public entry fun burn(
        cap: &mut TreasuryCap<FIROLL>, c: Coin<FIROLL>, amount: u64, ctx: &mut TxContext
    ): u64 {
        let coin_balance_ref = sui::coin::balance(&c);
        let coin_balance = sui::balance::value(coin_balance_ref);
        assert!(coin_balance >= amount, 0); // Add a descriptive error message here
        coin::burn(cap, c)
    }

    /// Wrapper of module initializer for testing
    #[test_only]
    public fun test_init(ctx: &mut TxContext) {
        init(FIROLL {}, ctx)
    }
}
