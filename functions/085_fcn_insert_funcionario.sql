--
-- Name: fcn_insert_funcionario(integer, integer, integer, integer, character varying, character, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION fcn_insert_funcionario(integer, integer, integer, integer, character varying, character, integer, integer) RETURNS integer
    AS $_$
DECLARE
  -- Par�metro recebidos
  v_matricula ALIAS for $1;
  v_id_ins ALIAS for $2;
  v_id_set ALIAS for $3;
  v_id_pes ALIAS for $4;
      v_situacao ALIAS for $5;
  v_origem_gravacao ALIAS for $6;
      v_idpes_cad ALIAS for $7;
      v_idsis_cad ALIAS for $8;
    -- Outras vari�veis
    v_id_set_aux integer;
BEGIN
    IF v_id_set = 0 THEN
        v_id_set_aux := NULL;
    ELSE
        v_id_set_aux := v_id_set;
    END IF;
  -- Insere dados na tabela funcion�rio
    INSERT INTO cadastro.funcionario (matricula,idins,idset,idpes,situacao, origem_gravacao, idpes_cad, idsis_cad, data_cad, operacao)
    VALUES(v_matricula,v_id_ins,v_id_set_aux,v_id_pes,public.fcn_upper(v_situacao), v_origem_gravacao, v_idpes_cad, v_idsis_cad, CURRENT_TIMESTAMP, 'I');
  RETURN 0;
END;$_$
    LANGUAGE plpgsql;