CREATE FUNCTION fcn_delete_funcionario(integer, integer) RETURNS integer
    AS $_$
DECLARE
  -- Par�metro recebidos
  v_matricula ALIAS for $1;
  v_id_ins ALIAS for $2;

BEGIN
  -- Deleta dados da tabela funcion�rio
  DELETE FROM cadastro.funcionario WHERE matricula = v_matricula AND idins = v_id_ins;
  RETURN 0;
END;$_$
    LANGUAGE plpgsql;