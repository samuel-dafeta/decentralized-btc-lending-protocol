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


;; Constants
(define-constant MIN-COLLATERAL-RATIO u150) ;; 150% minimum collateral ratio
(define-constant LIQUIDATION_THRESHOLD u130) ;; 130% liquidation threshold
(define-constant LIQUIDATION_PENALTY u10) ;; 10% penalty on liquidation
(define-constant PRICE_VALIDITY_PERIOD u3600) ;; 1 hour price validity
(define-constant CONTRACT-OWNER tx-sender)

;; Data Variables
(define-data-var total-loans uint u0)
(define-data-var total-collateral uint u0)
(define-data-var btc-price-in-cents uint u0)
(define-data-var last-price-update uint u0)
(define-data-var protocol-fee-percentage uint u1) ;; 1% fee

;; Principal Maps
(define-map loans 
    principal 
    {
        collateral-amount: uint,
        borrowed-amount: uint,
        last-update: uint,
        interest-rate: uint
    }
)

(define-map collateral-balances principal uint)
(define-map borrow-balances principal uint)

;; Read-only functions
(define-read-only (get-loan (user principal))
    (map-get? loans user)
)