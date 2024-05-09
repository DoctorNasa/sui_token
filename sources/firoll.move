module firoll::firoll {
    use std::option; // instead of using aliases for Self and UID
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::url;

    const IconUrl: vector<u8> = b"https://bafybeiecppfzpgx7xosf7h4a2zistip2d4lawqkwsp2dtp3ucmjpmnb6tq.ipfs.nftstorage.link/";
    // Name matches the module name, but in UPPERCASE
    public struct FIROLL has drop {}

    // Module initializer is called once on module publish.
    // A treasury cap is sent to the publisher, who then controls minting and burning.
    fun init(witness: FIROLL, ctx: &mut TxContext) {
        let ascii_url = std::ascii::string(IconUrl);
        let icon_url = url::new_unsafe(ascii_url);
    // Declare 'treasury' as mutable
        let (mut treasury, metadata) = coin::create_currency(witness, 9, b"PRO", b"FIROLL", b"FiRoll Coin for bet gaming protocol", option::some(icon_url), ctx);
        transfer::public_freeze_object(metadata);
        coin::mint_and_transfer(&mut treasury, 1000000000000000000, tx_context::sender(ctx), ctx);
        transfer::public_transfer(treasury, tx_context::sender(ctx));
}

    public entry fun mint(
        treasury: &mut coin::TreasuryCap<FIROLL>, amount: u64, recipient: address, ctx: &mut TxContext
    ) 
    {
        coin::mint_and_transfer(treasury, amount, recipient, ctx)
    }

    public entry fun burn<FIROLL>(
        cap: &mut coin::TreasuryCap<FIROLL>, 
        c: coin::Coin<FIROLL>
      ): u64
      {
        coin::burn(cap, c)}

    #[test_only]
    /// Wrapper of module initializer for testing
    ///     public fun test_init(ctx: &mut TxContext)
    public fun test_init(ctx: &mut TxContext) {
        init(FIROLL {}, ctx)
    } 
}
