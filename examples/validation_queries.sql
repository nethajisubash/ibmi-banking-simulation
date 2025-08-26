SELECT * FROM P1_PAYMENTS ORDER BY PAY_ID;            -- Status progression
SELECT * FROM P1_AUDIT_LOG  ORDER BY LOG_ID;          -- What happened and when
SELECT * FROM P1_SWIFT_OUTBOX ORDER BY MSG_ID;        -- SWIFT messages queued
SELECT * FROM P1_GL_ACCOUNTS;                         -- GL impact (clearing up)
SELECT * FROM P1_CUSTOMER_ACCTS ORDER BY CUST_ACCT;   -- Customer balances
