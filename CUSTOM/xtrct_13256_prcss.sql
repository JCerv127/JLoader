SET lines 10000
SET wrap OFF
SET head OFF
SET trimspool ON
SET pages 0
SET feed OFF

SPOOL xtrct_13256.txt

SELECT 'ACCT_NUM|CIF_ID|ACCT_STATUS|ACCT_BALANCE|LAST_DEBIT_TXN_DATE|LAST_CREDIT_TXN_DATE' FROM dual;

SELECT  a.jvar1||'|'||
        b.cif_id||'|'||
        c.acct_status||'|'||
        b.clr_bal_amt||'|'||            
        (   SELECT  MAX(d.tran_date) 
            FROM    htd d 
            WHERE   d.acid = b.acid
            AND     d.part_tran_type = 'D'
            AND     d.del_flg != 'Y'
            AND     d.pstd_flg = 'Y'
            AND     d.bank_id = '01'
        )||'|'||
        (   SELECT  MAX(e.tran_date) 
            FROM    htd e 
            WHERE   e.acid = b.acid
            AND     e.part_tran_type = 'C'
            AND     e.del_flg != 'Y'
            AND     e.pstd_flg = 'Y'
            AND     e.bank_id = '01'
        )
FROM    C_JSYNTBL a
LEFT OUTER JOIN 
        (gam b INNER JOIN smt c ON b.acid = c.acid)
ON      a.jvar1 = b.foracid;

SPOOL OFF

EXIT
