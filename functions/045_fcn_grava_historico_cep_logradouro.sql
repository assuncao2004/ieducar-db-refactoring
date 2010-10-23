CREATE FUNCTION fcn_grava_historico_cep_logradouro() RETURNS "trigger"
    AS $$
DECLARE
   v_cep    numeric;
   v_idlog    numeric;
   v_nroini   numeric;
   v_nrofin   numeric;
   v_idpes_rev    numeric;
   v_data_rev   TIMESTAMP;
   v_origem_gravacao  char(1);
   v_idsis_rev    numeric;
   v_idpes_cad    numeric;
   v_data_cad   TIMESTAMP;
   v_idsis_cad    numeric;
   v_operacao   char(1);
BEGIN
   v_cep    := OLD.cep;
   v_idlog    := OLD.idlog;
   v_nroini   := OLD.nroini;
   v_nrofin   := OLD.nrofin;
   v_idpes_rev    := OLD.idpes_rev;
   v_data_rev   := OLD.data_rev;
   v_origem_gravacao  := OLD.origem_gravacao;
   v_idsis_rev    := OLD.idsis_rev;
   v_idpes_cad    := OLD.idpes_cad;
   v_data_cad   := OLD.data_cad;
   v_idsis_cad    := OLD.idsis_cad;
   v_operacao   := OLD.operacao;

  IF v_data_rev IS NULL THEN
          v_data_rev := CURRENT_TIMESTAMP;
        END IF;

      -- GRAVA HIST�RICO PARA TABELA CEP_LOGRADOURO
      INSERT INTO historico.cep_logradouro
      (cep, idlog, nroini, nrofin, idpes_rev, data_rev, origem_gravacao, idsis_rev, idpes_cad, data_cad, idsis_cad, operacao) VALUES
      (v_cep, v_idlog, v_nroini, v_nrofin, v_idpes_rev, v_data_rev, v_origem_gravacao, v_idsis_rev, v_idpes_cad, v_data_cad, v_idsis_cad, v_operacao);

   RETURN NEW;

END; $$
    LANGUAGE plpgsql;