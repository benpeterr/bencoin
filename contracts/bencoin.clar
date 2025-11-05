;; BenCoin fungible token (SIP-010-like)
(define-constant ERR_UNAUTHORIZED_SENDER u401)

(define-fungible-token bencoin)

;; Read-only SIP-010 interface
(define-read-only (get-name)
  (ok "BenCoin")
)

(define-read-only (get-symbol)
  (ok "BEN")
)

(define-read-only (get-decimals)
  (ok u6)
)

(define-read-only (get-total-supply)
  (ok (some (ft-get-supply bencoin)))
)

(define-read-only (get-balance (owner principal))
  (ok (ft-get-balance bencoin owner))
)

(define-read-only (get-token-uri)
  (ok none)
)

;; Token functions
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
  (if (is-eq tx-sender sender)
      (ft-transfer? bencoin amount sender recipient)
      (err ERR_UNAUTHORIZED_SENDER)
  )
)

(define-public (mint (amount uint) (recipient principal))
  (ft-mint? bencoin amount recipient)
)

(define-public (burn (amount uint) (sender principal))
  (if (is-eq tx-sender sender)
      (ft-burn? bencoin amount sender)
      (err ERR_UNAUTHORIZED_SENDER)
  )
)
