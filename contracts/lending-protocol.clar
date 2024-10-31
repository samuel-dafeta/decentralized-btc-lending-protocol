;; BTC Lending Protocol
;; A decentralized lending platform built on Stacks
;; Version: 1.0.0

;; Error Codes
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INSUFFICIENT-BALANCE (err u101))
(define-constant ERR-INVALID-AMOUNT (err u102))
(define-constant ERR-BELOW-MINIMUM-COLLATERAL (err u103))
(define-constant ERR-LOAN-NOT-FOUND (err u104))
(define-constant ERR-LOAN-ALREADY-EXISTS (err u105))
(define-constant ERR-INVALID-LIQUIDATION (err u106))
(define-constant ERR-PRICE-EXPIRED (err u107))