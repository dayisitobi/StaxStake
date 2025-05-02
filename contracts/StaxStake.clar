;; StaxStake - Liquid Staking Protocol
;; Allows users to stake STX and receive stSTX tokens while earning rewards

(define-data-var total-staked uint u0)
(define-data-var reward-rate uint u500) ;; 5% annual rate (basis points)
(define-data-var last-reward-calculation uint u0)

(define-fungible-token stSTX)

(define-constant ERR-NOT-AUTHORIZED (err u401))
(define-constant ERR-INSUFFICIENT-BALANCE (err u402))
(define-constant ERR-ZERO-AMOUNT (err u403))

(define-public (stake (amount uint))
  (begin
    (asserts! (> amount u0) ERR-ZERO-AMOUNT)
    (asserts! (<= amount (stx-get-balance tx-sender)) ERR-INSUFFICIENT-BALANCE)
    
    ;; Transfer STX from sender to contract
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
    
    ;; Mint stSTX tokens to sender
    (try! (ft-mint? stSTX amount tx-sender))
    
    ;; Update total staked
    (var-set total-staked (+ (var-get total-staked) amount))
    
    (ok amount)))

(define-public (unstake (amount uint))
  (begin
    (asserts! (> amount u0) ERR-ZERO-AMOUNT)
    (asserts! (<= amount (ft-get-balance stSTX tx-sender)) ERR-INSUFFICIENT-BALANCE)
    
    ;; Burn stSTX tokens from sender
    (try! (ft-burn? stSTX amount tx-sender))
    
    ;; Transfer STX from contract to sender
    (try! (as-contract (stx-transfer? amount tx-sender tx-sender)))
    
    ;; Update total staked
    (var-set total-staked (- (var-get total-staked) amount))
    
    (ok amount)))

(define-read-only (get-total-staked)
  (var-get total-staked))

(define-read-only (get-reward-rate)
  (var-get reward-rate))

(define-public (update-reward-rate (new-rate uint))
  (begin
    (asserts! (is-eq tx-sender (contract-owner)) ERR-NOT-AUTHORIZED)
    (var-set reward-rate new-rate)
    (ok new-rate)))

(define-read-only (get-staking-stats)
  (let ((total (var-get total-staked))
        (rate (var-get reward-rate)))
    {total: total, rate: rate}))

(define-private (contract-owner)
  (contract-call? 'SP000000000000000000002Q6VF78.pox-3 get-pox-addr))