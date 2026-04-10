# PesaCrow: The User Journey

This document details the step-by-step experience for both Buyers and Sellers on the PesaCrow platform, from setup to final disbursement.

---

## 1. The Seller Journey
*The goal: Secure proof of payment before delivery and receive funds through a preferred channel.*

### Phase A: Setup & Onboarding
1.  **OTP Authentication**: Seller logs in using their M-Pesa phone number and a one-time password (OTP).
2.  **Payout Preferences**: The seller configures where they want their earnings to go.
    *   **Options**: Personal Wallet, Pochi La Biashara, Business Paybill, or Till Number.
    *   **Customization**: They can set a `payoutPhone` different from their login number.

### Phase B: Deal Creation
3.  **Initiate Deal**: Seller enters the Buyer's phone number, deal amount, and a description (e.g., "Selling 2021 MacBook Air").
4.  **Review Fees**: Seller sees the exact amount they will receive after PesaCrow fees are deducted.
5.  **Share Deal**: The system sends a unique **Transaction ID** (e.g., `ESC-KE-123456`) to the Buyer via SMS.

### Phase C: Escrow & Delivery
6.  **Escrow Notification**: Once the buyer pays, the seller receives an SMS: *"Funds for deal ESC-KE-123456 are now held in escrow. You can proceed with delivery."*
7.  **Fulfillment**: The seller delivers the product or service.
8.  **Proof of Delivery**: (Optional but Recommended) The seller uploads a photo or delivery note to the platform as evidence.

### Phase D: Get Paid
9.  **Release**: Once the buyer clicks 'Approve', PesaCrow instantly triggers the disbursement.
10. **Receipt**: Seller receives funds in their preferred channel (M-Pesa, Pochi, etc.) and a confirmation SMS with the M-Pesa receipt number.

---

## 2. The Buyer Journey
*The goal: Ensure the product or service is received as described before the money is released.*

### Phase A: Discovery
1.  **Receive Invitation**: The buyer receives an SMS alerting them that a PesaCrow deal has been created for them.
2.  **View Deal**: The buyer logs into the app or visits the deal link to verify the description, price, and seller's reputation.

### Phase B: Secure Payment
3.  **Confirm & Pay**: Buyer clicks "Pay Now".
4.  **STK Push**: A secure M-Pesa prompt appears on the buyer's phone. They enter their PIN to authorize the payment.
5.  **Funds Held**: Buyer receives an immediate confirmation that the funds are safely held in the PesaCrow escrow vault.

### Phase C: Inspection Period
6.  **Inspection**: Once the seller delivers, the buyer has a window of time to verify the item.
7.  **Quality Check**: Is it a MacBook Air? Does it work? Is it the right color?

### Phase D: Finalization or Dispute
8.  **Option 1: Approve**: If satisfied, the buyer clicks **"Approve & Release Funds"**. The transaction is complete.
9.  **Option 2: Dispute**: If the item is faulty, different, or never arrived, the buyer clicks **"Raise Dispute"**.
    *   The funds remain locked in escrow.
    *   An Admin reviews the evidence (chat logs, seller's proof of delivery).
10. **Refund**: If the dispute is settled in the buyer's favor, PesaCrow issues a refund directly to the buyer's wallet.

---

## 3. The Cancellation Flow (Security Feature)

*   **Before Payment**: Either party can cancel the deal. The record is removed from the system.
*   **After Payment**:
    *   If the seller realizes they cannot fulfill the order, they can cancel and trigger an **immediate M-Pesa reversal** back to the buyer.
    *   Once the reversal is confirmed, the deal is cleared from the database to maintain a clean workspace.

---

## 4. Key Security Milestones

| Action | Status | Security Meaning |
| :--- | :--- | :--- |
| **Buyer Pays** | `held` | Funds are "frozen" and cannot be touched by the seller until approval. |
| **Seller Marks Delivered** | `delivered` | The clock starts. Buyer is reminded to check the items. |
| **Buyer Approves** | `released` | The transaction is final. Funds move to the seller. |
| **Admin Ruling** | `refunded` | Funds are returned to the buyer after a failed seller delivery. |
