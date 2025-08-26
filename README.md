# IBM i Banking Simulation (PUB400)

This project demonstrates a **mini end-to-end banking workflow** built on **IBM i (AS/400, PUB400)**.  
It simulates the integration of **Finastra Equation (GL posting)**, **Finastra e-Gifts (sanctions screening)**, and **SWIFT MT103 message generation** into a seamless flow using DB2 SQL, CL, and batch jobs.

---

## 📌 Project Overview
The system processes customer payments through the following steps:
1. **Payment Entry** → Stored in `P1_PAYMENTS`.
2. **Sanctions Screening (e-Gifts-like)** → `P1_SCREEN_PAYMENT` checks against `P1_SANCTIONS`.
3. **GL Posting (Equation-like)** → `P1_POST_GL` debits customer accounts and credits a clearing GL.
4. **SWIFT Message Creation** → `P1_QUEUE_SWIFT` generates MT103 messages into `P1_SWIFT_OUTBOX`.
5. **Batch Orchestration** → `P1_EOD_BATCH` automates the entire flow.
6. **Audit Logging** → `P1_AUDIT_LOG` records all key actions.

---

## 📂 Repository Structure
ibmi-banking-simulation/
│
├── README.md # Project documentation
├── docs/
│ ├── architecture.png # Flow diagram (Equation → e-Gifts → SWIFT)
│ ├── payments_result.png # Screenshot of P1_PAYMENTS
│ ├── swift_outbox.png # Screenshot of P1_SWIFT_OUTBOX
│ ├── audit_log.png # Screenshot of P1_AUDIT_LOG
│ └── usage_guide.md # Step-by-step instructions
├── sql/
│ ├── P1_tables.sql # CREATE TABLE scripts
│ ├── P1_procedures.sql # Stored procedures
│ ├── P1_batch_driver.sql # EOD batch driver
│ └── P1_sample_data.sql # Seed/test data
├── cl/
│ └── P1EOD.CLLE # CL program to run batch
├── examples/
│ ├── sample_payments.sql # Inserts for test payments
│ └── validation_queries.sql # Queries to validate results
└── LICENSE


## ⚙️ How to Run on PUB400
1. **Login to PUB400**
   ```bash
   ssh -p 2222 netajisub@pub400.com


Set your library

CHGCURLIB CURLIB(NETAJISUB1)


Create tables and objects

Open STRSQL

Run scripts in:

sql/P1_tables.sql

sql/P1_procedures.sql

sql/P1_batch_driver.sql

sql/P1_sample_data.sql

Insert payments
Run examples/sample_payments.sql inside STRSQL.

Run batch process

Interactive:

CALL P1_EOD_BATCH();


Background:

SBMJOB CMD(CALL PGM(NETAJISUB1/P1EOD))


Check results

SELECT * FROM P1_PAYMENTS;
SELECT * FROM P1_SWIFT_OUTBOX;
SELECT * FROM P1_AUDIT_LOG;

✅ Example Screenshots
Payment Processing (P1_PAYMENTS)

Outbound SWIFT Messages (P1_SWIFT_OUTBOX)

Audit Log (P1_AUDIT_LOG)

🛠️ Technologies Used

IBM i (AS/400, PUB400)

DB2 SQL

CL (Control Language)

SWIFT MT103 Standards

OFAC Sanctions Screening

🚀 Future Enhancements

Add MT940 mini-statements for account reporting.

Extend GL reconciliation to simulate Nostro accounts.

Create interactive dashboards using Python + SSH integration.

📜 License

This project is licensed under the MIT License. See LICENSE
 for details.

👤 Author: Subash Srinivasan
🔗 GitHub: nethajisubash
