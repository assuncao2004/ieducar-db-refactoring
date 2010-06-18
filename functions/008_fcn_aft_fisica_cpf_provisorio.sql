--
-- Name: fcn_aft_fisica_cpf_provisorio(); Type: FUNCTION; Schema: cadastro; Owner: -
--

CREATE FUNCTION fcn_aft_fisica_cpf_provisorio() RETURNS "trigger"
    AS $$
DECLARE
  v_idpes       numeric;
  v_cpf       numeric;
  v_verificacao_provisorio  numeric;
  
  v_comando     text;
  v_registro      record;
  
  BEGIN
    v_idpes     := NEW.idpes;
    v_cpf     := COALESCE(NEW.cpf, -1);
    
    v_verificacao_provisorio:= 0;
    
    -- verificar se a situa��o do cadastro da pessoa � provis�rio
    FOR v_registro IN SELECT situacao FROM cadastro.pessoa WHERE idpes=v_idpes LOOP
      IF v_registro.situacao = 'P' THEN
        v_verificacao_provisorio := 1;
      END IF;
    END LOOP;
    
    -- Verifica��o para atualizar ou n�o a situa��o do cadastro da pessoa para Ativo
    IF v_cpf > 0 AND v_verificacao_provisorio = 1 THEN
      EXECUTE 'UPDATE cadastro.pessoa SET situacao='||quote_literal('A')||'WHERE idpes='||quote_literal(v_idpes)||';';
    END IF;
  RETURN NEW;
END; $$
    LANGUAGE plpgsql;