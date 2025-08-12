;; KYC-less Enrollment via Wallet Ownership

;; Constants
(define-constant err-wallet-already-enrolled (err u101))
(define-constant err-wallet-not-enrolled (err u102))

;; Data structure to track enrollment
(define-map enrolled-wallets principal bool)

;; Function to enroll wallet (only once per wallet)
(define-public (enroll-wallet)
  (let ((existing (map-get? enrolled-wallets tx-sender)))
    (begin
      (asserts! (is-none existing) err-wallet-already-enrolled)
      (map-set enrolled-wallets tx-sender true)
      (ok true))))

;; Function to check if wallet is enrolled
(define-read-only (is-wallet-enrolled (wallet principal))
  (let ((enrolled-status (map-get? enrolled-wallets wallet)))
    (match enrolled-status
      some-status (ok some-status)
      (ok false))))
      