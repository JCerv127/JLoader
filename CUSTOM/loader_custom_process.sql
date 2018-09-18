--##########################################################################
--  Name                    :   loader_custom_process.sql
--  Description             :   
--  Input                   :   
--  Output                  :  
--  Author                  :   JAGCERVANTES
--  Called Script           :   NA
--  Calling Script          :   NA
--  Reference               :   NA
--  Assumptions             :   NA
--  Modification History    :
--       <Serial No.>     <Date>      <Author Name>     <Description>
--            00        04-SEP-2018     JAGCERVANTES      Initial Dev
--###########################################################################
-------------------------------------
--Addtnl Cnfg
-------------------------------------
SET head OFF
SET feedback OFF
SET wrap OFF
SET pages 0
SET linesize 10000
SET trimspool ON
SET verify OFF
SET echo OFF
SET termout OFF
SET serveroutput ON size unlimited

COLUMN v_ymd  OLD_VALUE    _ymd
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') AS v_ymd FROM dual;
SPOOL loader_output.txt

-------------------------------------
--Variable Declaration and Initialization
-------------------------------------
DECLARE

    ---------------------------------
    --Fields for Extraction
    ---------------------------------    
    lv_foracid                      VARCHAR2(25);
    lv_schmCode                     VARCHAR2(25);

    ---------------------------------
    --Other Variables
    ---------------------------------
    --Constants
    lv_dlr                          VARCHAR2(5) NOT NULL := '|';
    lv_bankid                       VARCHAR2(5) := '01';
    
    --Helper/Connecting Vars
    -- NONE

    --Formatted for Display Vars
    -- NONE

    --Test Vars
    -- NONE

    --Output Var
    output                          VARCHAR2(2000);

-------------------------------------
--Cursor Declaration (CUSTOM for LOADER)
-------------------------------------
CURSOR      c_curs IS
    SELECT  jvar1   var1 
    FROM    c_jsyntbl    
;

-------------------------------------
--Func Declaration (Display Header)
-------------------------------------
FUNCTION fnc_dispHeader
RETURN LONG IS
    fv_outLong   LONG(10000);    
BEGIN    
    fv_outLong := 'ACCT_NUM|SCHM_CODE';    
    RETURN fv_outLong;
END;

-------------------------------------
--Begin SQL Loop Extraction
-------------------------------------
BEGIN
    --Display Header    
    DBMS_OUTPUT.PUT_LINE(fnc_dispHeader());

    FOR n IN c_curs
    LOOP

        ---------------------------------
        --Assignment of Variables from Cursor
        ---------------------------------        
        lv_foracid    :=  n.var1;
        
        ---------------------------------
        --Fetching from other Source
        ---------------------------------
        -- SCHM_CODE
        BEGIN
            SELECT  gam.schm_code
            INTO    lv_schmCode
            FROM    gam 
            WHERE   gam.foracid = lv_foracid
            AND     gam.bank_id = lv_bankid;
        EXCEPTION
            WHEN    NO_DATA_FOUND THEN
                    lv_schmCode := '---';                                        
        END;   

        
        ---------------------------------
        --Output Appendation
        ---------------------------------        
        output  := lv_foracid || lv_dlr;
        output  := output || lv_schmCode;
        
        DBMS_OUTPUT.PUT_LINE(output);  
            
    END LOOP;
END;
/
--SELECT UNIQUE(text) FROM my_dbms_output_view WHERE text IS NOT NULL ORDER BY text DESC;
SPOOL OFF
EXIT
