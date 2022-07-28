CREATE OR REPLACE FUNCTION min3( pVal1 numeric DEFAULT null, pVal2 numeric DEFAULT null, pVal3 numeric DEFAULT null) 
	RETURNS numeric 
	AS 'select least(pVal1, pVal2, pVal3);'
    LANGUAGE SQL
    /*IMMUTABLE*/
    /*RETURNS NULL ON NULL INPUT*/;

CREATE OR REPLACE FUNCTION min3( pVal1 numeric DEFAULT null, pVal2 numeric DEFAULT null, pVal3 numeric DEFAULT null) 
	RETURNS numeric 
	AS 'select least(pVal1, pVal2, pVal3);'
    LANGUAGE SQL;