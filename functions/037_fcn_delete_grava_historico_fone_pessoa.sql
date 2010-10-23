CREATE FUNCTION fcn_delete_grava_historico_fone_pessoa() RETURNS "trigger"
    AS $$
DECLARE
   v_idpes      numeric;
   v_tipo     numeric;
   v_ddd      numeric;
   v_fone     numeric;
   v_idpes_rev      numeric;
   v_data_rev     TIMESTAMP;
   v_origem_gravacao    char(1);
   v_idsis_rev      numeric;
   v_idpes_cad      numeric;
   v_data_cad     TIMESTAMP;
   v_idsis_cad      numeric;
BEGIN
   v_idpes      := OLD.idpes;
   v_tipo     := OLD.tipo;
   v_ddd      := OLD.ddd;
   v_fone     := OLD.fone;
   v_idpes_rev      := OLD.idpes_rev;
   v_data_rev     := OLD.data_rev;
   v_origem_gravacao    := OLD.origem_gravacao;
   v_idsis_rev      := OLD.idsis_rev;
   v_idpes_cad      := OLD.idpes_cad;
   v_data_cad     := OLD.data_cad;
   v_idsis_cad      := OLD.idsis_cad;

  IF v_data_rev IS NULL THEN
          v_data_rev := CURRENT_TIMESTAMP;
        END IF;

      -- GRAVA HIST�RICO PARA TABELA FONE_PESSOA
      INSERT INTO historico.fone_pessoa
      (idpes, tipo, ddd, fone, idpes_rev, data_rev, origem_gravacao, idsis_rev, idpes_cad, data_cad, idsis_cad, operacao) VALUES
      (v_idpes, v_tipo, v_ddd, v_fone, v_idpes_rev, v_data_rev, v_origem_gravacao, v_idsis_rev, v_idpes_cad, v_data_cad, v_idsis_cad, 'E');

   RETURN NEW;

END; $$
    LANGUAGE plpgsql;