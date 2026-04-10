# PesaCrow Escrow System: Core Working Principles

This document explains how the PesaCrow Escrow service functions at both a high strategic level and a low technical level, including the fee structure and the interaction between the frontend and backend.

---

## 1. High-Level Flow (The "Safe Middleman")

PesaCrow acts as a trusted third party that holds funds during a transaction to ensure both the Buyer and Seller are protected.

1.  **Deal Creation**: One party (Buyer or Seller) initiates a deal specifying the amount and description.
2.  **Payment (Funds Secured)**: The Buyer pays the deal amount plus a transaction fee. The platform holds these funds in a specialized account (Escrow).
3.  **Delivery**: The Seller delivers the goods or services and marks the deal as "Delivered" in the app.
4.  **Acceptance**: The Buyer inspects the goods and approves the deal.
5.  **Disbursement (Payout)**: PesaCrow automatically releases the net funds to the Seller's preferred M-Pesa channel.

---

## 2. Combined Fee Model (Bouquet + PesaCrow)

The platform uses a combined model that integrates **Safaricom Business Bouquet** charges with PesaCrow's service fees. All fees are rounded up (`Math.ceil()`) to the nearest Kenyan Shilling.

| Fee Component | Amount | Paid By | Description |
| :--- | :--- | :--- | :--- |
| **Safaricom Bouquet** | **Fixed (KSh 0–210)** | **Buyer** | Standard Safaricom Paybill charge based on deal range. |
| **Transaction Fee** | **2.0% (min KSh 20)** | **Buyer** | PesaCrow service fee. Drops to 1.8%/1.5% for large deals. |
| **Release Fee** | **1.5% (min KSh 10)** | **Seller** | Platform fee deducted on release. Drops to 1.2%/1.0% for large deals. |
| **PesaCrow Share** | **50% of Bouquet** | **-** | PesaCrow retains 50% of the Safaricom charge as revenue. |

**Example (KSh 200 Deal):**
-   **Safaricom Charge**: KSh 5 (Range 101–500).
-   **Transaction Fee**: KSh 20 (Minimum applied).
-   **Buyer Pays**: KSh 225 (200 + 5 + 20).
-   **Seller Receives**: KSh 190 (200 - 10 platform fee).
-   **Platform Earnings**: KSh 33 (20 Tx + 10 Release + 3 Revenue Share).

**Example (KSh 5,000 Deal):**
-   **Safaricom Charge**: KSh 34 (Range 3,501–5,000).
-   **Transaction Fee**: KSh 100 (2% of 5,000).
-   **Buyer Pays**: KSh 5,134.
-   **Seller Receives**: KSh 4,925.
-   **Platform Earnings**: KSh 192 (100 + 75 + 17).

---

## 3. Low-Level Technical Lifecycle

### Backend (The "Brain")
Built with Node.js, Express, and MongoDB, the backend enforces the **Escrow State Machine**.

-   **State Machine**: A transaction MUST follow a strict sequence (e.g., you cannot "Release" funds if the status isn't "Approved"). This prevents double-spending or accidental releases.
-   **Daraja API Integration**:
    *   **STK Push (C2B)**: Triggers the M-Pesa prompt on the Buyer's phone.
    *   **B2C / B2B Disbursement**: Automatically pays out to the Seller via the channel of their choice (Wallet, Pochi, Till, or Paybill).
-   **Security Webhooks**: Safaricom notifies our server when a payment is successful. We use **IP Whitelisting** to ensure these notifications actually come from Safaricom.
-   **Dual-Buyer Identity**: Uses both the payer's phone and their authenticated account phone to ensure role-based access control (RBAC).

### Frontend (The "Face")
The client application (Flutter) manages the user journey and provides real-time visibility.

-   **OTP Authentication**: Users log in using a 6-digit code sent to their phone (2FA). There are no passwords to remember.
-   **JWT Session**: A secure token is stored locally to authorize API requests.
-   **Polling & Status Updates**: The app frequently checks the backend for status changes (e.g., "Paid," "Delivered") to update the UI instantly.
-   **FileUploads**: Buyers and Sellers can upload photos/PDFs as "Proof of Delivery" or for "Dispute Resolution."

### Disbursement Routing
When a Buyer approves a deal:
1.  The system checks the Seller's **Payout Preference**.
2.  It calculates the `netPayout` (Amount - 1.5%).
3.  It calls the relevant Daraja API:
    *   `callB2C`: Standard Phone Number.
    *   `callB2Pochi`: Pochi La Biashara.
    *   `businessBuyGoods`: Till Number.
    *   `businessPayBill`: PayBill Shortcode.

---

## 4. Safety Nets & Edge Cases

-   **Disputes**: If the items are not as described, the Buyer can "Raise a Dispute." This freezes the funds and notifies an Admin for manual review.
-   **Auto-Expiry**: If a deal sits in "Delivered" too long without Buyer response, it can be automatically approved (configurable).
-   **Cancellations & Reversals**: Sellers can intentionally cancel a deal at any time before approval. If payment was already made, PesaCrow triggers an asynchronous M-Pesa **Reversal** to return funds to the Buyer.
-   **Late Payments**: If a payment arrives for a deal that was already automatically timed out or cancelled, the system triggers a reversal to ensure funds are not trapped.
