CREATE FUNCTION fcn_aft_documento_provisorio() RETURNS "trigger"
    AS $$
DECLARE
  v_idpes       numeric;
  v_rg        numeric;
  v_uf_expedicao      text;
  v_verificacao_provisorio  numeric;

  v_comando     text;
  v_registro      record;

  BEGIN
    v_idpes     := NEW.idpes;
    v_rg      := COALESCE(NEW.rg, -1);
    v_uf_expedicao    := TRIM(COALESCE(NEW.sigla_uf_exp_rg, ''));

    v_verificacao_provisorio:= 0;

    -- verificar se a situa��o do cadastro da pessoa � provis�rio
    FOR v_registro IN SELECT situacao FROM cadastro.pessoa WHERE idpes=v_idpes LOOP
      IF v_registro.situacao = 'P' THEN
        v_verificacao_provisorio := 1;
      END IF;
    END LOOP;

    -- Verifica��o para atualizar ou n�o a situa��o do cadastro da pessoa para Ativo
    IF LENGTH(v_uf_expedicao) > 0 AND v_rg > 0 AND v_verificacao_provisorio = 1 THEN
      EXECUTE 'UPDATE cadastro.pessoa SET situacao='||quote_literal('A')||'WHERE idpes='||quote_literal(v_idpes)||';';
    END IF;
  RETURN NEW;
END; $$
    LANGUAGE plpgsql;