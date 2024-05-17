module game::betting {
    use std::option;
    use sui::coin::{Self, TreasuryCap, Coin, CoinMetadata};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::balance::{Self, Balance};
    use sui::object;
    use sui::url;
    
    const IconUrl: vector<u8> = b"https://bafybeiecppfzpgx7xosf7h4a2zistip2d4lawqkwsp2dtp3ucmjpmnb6tq.ipfs.nftstorage.link/";

    /// Shared object used to manage betting schedules
    public struct Registry has key {
        id: UID,
        metadata: CoinMetadata<FIROLL>,
        schedules: vector<Schedule>,
        bets: vector<Bet>
    }

    /// Struct representing a betting schedule
    public struct Schedule has store {
        id: u64,
        teamAId: u64,
        teamARate: u64,
        teamBId: u64,
        teamBRate: u64,
        status: bool,
        teamWin: u64
    }

    /// Struct representing a bet
    public struct Bet has store {
        id: u64,
        player: address,
        scheduleId: u64,
        teamId: u64,
        amount: u64,
        timestamp: u64,
        fulfill: bool
    }

    /// Create a new schedule
    public entry fun create_schedule(
        registry: &mut Registry, schedule_id: u64, teamAId: u64, teamARate: u64, teamBId: u64, teamBRate: u64, ctx: &mut TxContext
    ) {
        assert!(schedule_id > 0, 0);
        assert!(teamAId > 0, 0);
        assert!(teamARate > 0, 0);
        assert!(teamBId > 0, 0);
        assert!(teamBRate > 0, 0);

        let schedule = Schedule {
            id: schedule_id,
            teamAId,
            teamARate,
            teamBId,
            teamBRate,
            status: false,
            teamWin: 0
        };
        
        vector::push_back(&mut registry.schedules, schedule);
    }

    /// Open a schedule
    public entry fun open_schedule(registry: &mut Registry, schedule_id: u64) {
        let mut schedule = vector::find_mut(&mut registry.schedules, |s| s.id == schedule_id).unwrap();
        schedule.status = true;
    }

    /// Close a schedule and set the winning team
    public entry fun close_schedule(registry: &mut Registry, schedule_id: u64, teamWin: u64) {
        let mut schedule = vector::find_mut(&mut registry.schedules, |s| s.id == schedule_id).unwrap();
        schedule.status = false;
        schedule.teamWin = teamWin;
    }

    /// Place a bet on a schedule
    public entry fun place_bet(
        registry: &mut Registry, bet_id: u64, schedule_id: u64, team_id: u64, amount: u64, player: address, ctx: &mut TxContext
    ) {
        let schedule = vector::find(&registry.schedules, |s| s.id == schedule_id).unwrap();
        assert!(schedule.status, 0);

        let bet = Bet {
            id: bet_id,
            player,
            scheduleId: schedule_id,
            teamId: team_id,
            amount,
            timestamp: tx_context::timestamp(ctx),
            fulfill: false
        };

        vector::push_back(&mut registry.bets, bet);
        coin::transfer(ctx, player, amount);
    }

    /// Collect the prize for a winning bet
    public entry fun collect_prize(
        registry: &mut Registry, bet_id: u64, schedule_id: u64, ctx: &mut TxContext
    ) {
        let schedule = vector::find(&registry.schedules, |s| s.id == schedule_id).unwrap();
        assert!(!schedule.status, 0);

        let mut bet = vector::find_mut(&mut registry.bets, |b| b.id == bet_id).unwrap();
        assert!(bet.player == tx_context::sender(ctx), 0);
        assert!(!bet.fulfill, 0);

        let rate = if bet.teamId == schedule.teamAId {
            schedule.teamARate
        } else {
            schedule.teamBRate
        };

        assert!(rate > 0, 0);

        if bet.teamId == schedule.teamWin {
            let prize_amount = bet.amount * rate / 100;
            let total = bet.amount + prize_amount;
            coin::transfer(ctx, bet.player, total);
            bet.fulfill = true;
        } else {
            // Add appropriate handling for a losing bet
        }
    }
}
