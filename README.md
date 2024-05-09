Failed to publish the Move module(s), reason: [warning] Local dependency did not match its on-chain version at 0000000000000000000000000000000000000000000000000000000000000001::MoveStdlib::type_name

This may indicate that the on-chain version(s) of your package's dependencies may behave differently than the source version(s) your package was built against.

Fix this by rebuilding your packages with source versions matching on-chain versions of dependencies, or ignore this warning by re-running with the --skip-dependency-verification flag.
❯ sui client publish --gas-budget 100000000 --skip-dependency-verification
[warn] Client/Server api version mismatch, client api version : 1.24.0, server api version : 1.25.0
UPDATING GIT DEPENDENCY https://github.com/MystenLabs/sui.git
INCLUDING DEPENDENCY Sui
INCLUDING DEPENDENCY MoveStdlib
BUILDING firoll
warning[W02021]: duplicate alias
  ┌─ ./sources/firoll.move:2:14
  │
2 │     use std::option; // instead of using aliases for Self and UID
  │              ^^^^^^ Unnecessary alias 'option' for module 'std::option'. This alias is provided by default
  │
  = This warning can be suppressed with '#[allow(duplicate_alias)]' applied to the 'module' or module member ('const', 'fun', or 'struct')

warning[W02021]: duplicate alias
  ┌─ ./sources/firoll.move:4:23
  │
4 │     use sui::object::{Self, UID};
  │                       ^^^^ Unnecessary alias 'object' for module 'sui::object'. This alias is provided by default
  │
  = This warning can be suppressed with '#[allow(duplicate_alias)]' applied to the 'module' or module member ('const', 'fun', or 'struct')

========================
0x2::coin::TreasuryCap<0xa4d3cc5557ca16ecfcdfc71a4d15c6b373004d2b3aa0678e367e7b50ce7d3a3::firoll::FIROLL>
0x2::coin::firoll::FIROLL
0x2::firoll::FIROLL
0x2::sui::SUI
0x0a4d3cc5557ca16ecfcdfc71a4d15c6b373004d2b3aa0678e367e7b50ce7d3a3

==================================
 PackageID: 0x7306e00d2f9822dea504abbc51bb49bf439dc21497290114d0180ac71e335886                                            │
│  │ Version: 1                                                                                                               │
│  │ Digest: 2J2vGjGBEaWBvD84rBdZE1Rce66Xmwstq2RguhdRb65i                                                                     │
│  │ Modules: firoll    

0x2::coin::TreasuryCap<0x7306e00d2f9822dea504abbc51bb49bf439dc21497290114d0180ac71e335886::firoll::FIROLL>

========
Alternative output
$ sui client publish --gas-budget 100000000 --json
possible to specify the --json flag during publishing to get the output in JSON format. 

sui client publish --gas-budget 100000000 --skip-dependency-verification  --json

========
Building the Transaction in CLI
$ sui client ptb \
--gas-budget 100000000 \
--assign sender @$MY_ADDRESS \
--move-call $PACKAGE_ID::todo_list::new \
--assign list \
--transfer-objects "[list]" sender
========
mint token

sui client call --package <PACKAGE_ID> --module supra --function mint --args <TREASURYCAP_ID> 1000000 <RECIPIENT_ADDRESS> --gas-budget 300000000

sui client call --package 0x68f635cd81f5dfdb578ae8aa1ab159f1a6c00a77319c4ef6230c91b27d3dc8ff  --module firoll --function mint --args 0x68f635cd81f5dfdb578ae8aa1ab159f1a6c00a77319c4ef6230c91b27d3dc8ff 1000000 0xf91ff19530f8b905775553e2337a76d39774e27cc0ce100c9faeb87d3c10691c --gas-budget 30000000000

--------- = 
---------- = 
sui client ptb \
--move-call package::module::function "<u64,u8,u256>"
--gas-budget 50000000 --preview

sui client ptb \
--gas-budget 300000000 \
--move-call 0x68f635cd81f5dfdb578ae8aa1ab159f1a6c00a77319c4ef6230c91b27d3dc8ff::firoll::mint \
0xc8c020b530ca242eeb360cf54813b56ae5b7b595cf1f695961ca844d88a30bbd 1000 0xf91ff19530f8b905775553e2337a76d39774e27cc0ce100c9faeb87d3c10691c 

sui client ptb \
--move-call package::module::function "<u64,u8,u256>"
--gas-budget 50000000 --preview

sui client ptb \
--gas-budget 100000000 \
--move-call 0x7306e00d2f9822dea504abbc51bb49bf439dc21497290114d0180ac71e335886::firoll::mint \
"0x123456789abcdef0" "1000" "0xfedcba9876543210"   --preview
This command assumes:


"0x123456789abcdef0" is the treasury capability object ID.
"1000" is the amount to be minted.
"0xfedcba9876543210" is the recipient's address.
=====
sui client object <object_id>
=====
