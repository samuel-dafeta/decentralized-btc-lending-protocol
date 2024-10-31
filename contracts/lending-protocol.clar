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

(define-read-only (get-collateral-balance (user principal))
    (default-to u0 (map-get? collateral-balances user))
)

(define-read-only (get-borrow-balance (user principal))
    (default-to u0 (map-get? borrow-balances user))
)

(define-read-only (get-current-collateral-ratio (user principal))
    (let (
        (loan (unwrap! (get-loan user) (err u0)))
        (collateral-value (* (get collateral-amount loan) (var-get btc-price-in-cents)))
        (borrowed-value (* (get borrowed-amount loan) u100))
    )
    (/ (* collateral-value u100) borrowed-value))
)


;; Price Oracle Functions
(define-public (update-btc-price (new-price-in-cents uint))
    (begin
        (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
        (var-set btc-price-in-cents new-price-in-cents)
        (var-set last-price-update block-height)
        (ok true))
)


(define-read-only (is-price-valid)
    (< (- block-height (var-get last-price-update)) PRICE_VALIDITY_PERIOD)
)

;; Core Lending Functions
(define-public (deposit-collateral (amount uint))
    (begin
        (asserts! (> amount u0) ERR-INVALID-AMOUNT)
        (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
        
        (map-set collateral-balances 
            tx-sender 
            (+ (get-collateral-balance tx-sender) amount))
        
        (var-set total-collateral (+ (var-get total-collateral) amount))
        (ok true))
)


(define-public (borrow (amount uint))
    (let (
        (current-collateral (get-collateral-balance tx-sender))
        (current-loan (get-loan tx-sender))
        (collateral-value (* current-collateral (var-get btc-price-in-cents)))
    )
        (asserts! (is-price-valid) ERR-PRICE-EXPIRED)
        (asserts! (> amount u0) ERR-INVALID-AMOUNT)
        (asserts! (is-none current-loan) ERR-LOAN-ALREADY-EXISTS)
        (asserts! (>= (* collateral-value u100) (* amount MIN-COLLATERAL-RATIO)) ERR-BELOW-MINIMUM-COLLATERAL)
        
        (map-set loans 
            tx-sender
            {
                collateral-amount: current-collateral,
                borrowed-amount: amount,
                last-update: block-height,
                interest-rate: u5 ;; 5% APR
            })
        
        (map-set borrow-balances 
            tx-sender 
            (+ (get-borrow-balance tx-sender) amount))
        
        (var-set total-loans (+ (var-get total-loans) amount))
        (ok true))
)