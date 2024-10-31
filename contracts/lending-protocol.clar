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