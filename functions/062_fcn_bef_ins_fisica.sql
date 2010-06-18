--
-- Name: fcn_bef_ins_fisica(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION fcn_bef_ins_fisica() RETURNS "trigger"
    AS $$
   DECLARE
    v_idpes    cadastro.fisica.idpes%TYPE;
    v_contador integer;
   BEGIN
    SELECT INTO v_contador count(idpes) from cadastro.juridica where idpes = NEW.idpes;
    IF v_contador = 1 THEN
     RAISE EXCEPTION 'O Identificador % j� est� cadastrado como Pessoa Jur�dica', NEW.idpes;
    END IF;
    RETURN NEW;
   END;
  $$
    LANGUAGE plpgsql;