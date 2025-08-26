# ibmi-banking-simulation
“Mini banking workflow on IBM i (PUB400) simulating Finastra Equation (GL posting), e-Gifts (sanctions screening), and SWIFT MT103 message generation using DB2 SQL &amp; CL.”

ibmi-banking-simulation/
│
├── README.md # Project documentation
├── docs/
│ ├── architecture.png # Flow diagram (Equation → e-Gifts → SWIFT)
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

Always show details

---

## ⚙️ How to Run on PUB400
1. **Login to PUB400**
   ```bash
   ssh -p 2222 netajisub@pub400.com


Set your library

Always show details
CHGCURLIB CURLIB(NETAJISUB1)


Create tables and objects

Open STRSQL

Run scripts in sql/P1_tables.sql, sql/P1_procedures.sql, sql/P1_batch_driver.sql, sql/P1_sample_data.sql.

Insert payments
Run examples/sample_payments.sql inside STRSQL.

Run batch process

Interactive:

Always show details
CALL P1_EOD_BATCH();


Background:

Always show details
SBMJOB CMD(CALL PGM(NETAJISUB1/P1EOD))


Check results

Always show details
SELECT * FROM P1_PAYMENTS;
SELECT * FROM P1_SWIFT_OUTBOX;
SELECT * FROM P1_AUDIT_LOG;

✅ Expected Results

Approved payments → Debited from customer accounts, credited to clearing GL, MT103 created.

Sanctions hit → Blocked with status OFAC_HIT, logged in audit.

Audit log → Tracks each stage for traceability.

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
