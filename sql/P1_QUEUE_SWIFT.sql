-bash-5.2$ cat P1_QUEUE_SWIFT.sql
CREATE OR REPLACE PROCEDURE P1_QUEUE_SWIFT (IN p_pay_id INT)
LANGUAGE SQL
BEGIN
  DECLARE v_from   CHAR(14);
  DECLARE v_bene   VARCHAR(60);
  DECLARE v_bic    CHAR(11);
  DECLARE v_amt    DECIMAL ;
  DECLARE v_curr   CHAR(3);
  DECLARE v_status VARCHAR(12);
  DECLARE v_msg CLOB(10K);

  SELECT FROM_ACCT, TO_BENENAME, TO_BENEBIC, AMT, CURR, STATUS
    INTO v_from,   v_bene,     v_bic,      v_amt, v_curr, v_status
  FROM P1_PAYMENTS WHERE PAY_ID=p_pay_id;

  IF v_status <> 'POSTED' THEN
    SIGNAL SQLSTATE '75001'
      SET MESSAGE_TEXT = 'Payment not posted; cannot create SWIFT';
  END IF;

  SET v_msg = ':{1:F01NBKUS33AXXX}' ||
              ':{2:O103}' ||
              ':{20:PAY' || TRIM(CHAR(p_pay_id)) || '}' ||
              ':{23B:CRED}' ||
              ':{32A:' || CHAR(CURRENT_DATE, USA) || v_curr ||
              TRIM(CHAR(v_amt)) || '}' ||
              ':{50K:/' || v_from || '}' ||
              v_bene ||
              ':{57A:' || v_bic || '}' ||
              ':{59:/' || v_bic || '}' || v_bene;

  INSERT INTO P1_SWIFT_OUTBOX (PAY_ID, MT_TYPE, RAW_TEXT, STATUS)
  VALUES (p_pay_id, 'MT103', v_msg, 'QUEUED');

  UPDATE P1_PAYMENTS SET STATUS='SENT' WHERE PAY_ID=p_pay_id;

  INSERT INTO P1_AUDIT_LOG (ENTITY, REF_ID, ACTION, DETAILS)
  VALUES ('SWIFT', CAST(p_pay_id AS VARCHAR(20)),'QUEUE','MT103 queued');
END;
